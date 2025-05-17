/*
CREATING A STAGING TABLE
To store raw data directly from the CSV file before normalization
*/
CREATE TABLE staging_movies (
    id VARCHAR,
    title TEXT,
    type TEXT,
    description VARCHAR,
    release_year INTEGER,
    age_certification TEXT,
    runtime INTEGER,
    genre TEXT[], -- array
    production_countries TEXT[] -- array
);

/*
LOADING DATA FROM movies.csv INTO THE STAGING TABLE
*/
COPY staging_movies(id, title, type, description, release_year, age_certification, runtime, genre, production_countries)
FROM '/private/tmp/movies.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM staging_movies

/*
DATA NORMALIZATION
The database structure is normalized to the Third Normal Form (3NF), minimizing redundancy and separating entities.
*/

/*1. movies table (main table)
Stores core movie data (excluding arrays)
*/
CREATE TABLE movies (
    id VARCHAR PRIMARY KEY,
    title TEXT,
    type TEXT,
    description TEXT,
    release_year INTEGER,
    age_certification TEXT,
    runtime INTEGER
);

/*
2. movie_genres table (many-to-many. relationship)
*/
CREATE TABLE movie_genres (
    movie_id VARCHAR REFERENCES movies(id),
    genre TEXT,
    PRIMARY KEY(movie_id, genre)
); 
-- One movie can have multiple genres
-- Normalize the genre[] array using UNNEST():
INSERT INTO movie_genres (movie_id, genre)
SELECT id, UNNEST(genre)
FROM staging_movies;


/*
3. movie_countries table (many-to-many relationship)
*/
CREATE TABLE movie_countries (
    movie_id VARCHAR REFERENCES movies(id),
    country TEXT,
    PRIMARY KEY(movie_id, country)
);
-- One movie can be produced by more than one country
-- Normalize the production_countries[] array using:
INSERT INTO movie_countries (movie_id, country)
SELECT id, UNNEST(production_countries)
FROM staging_movies;

/*
INSERT DATA INTO THE FINAL TABLE
*/
-- Insert into the main table
INSERT INTO movies (id, title, type, description, release_year, age_certification, runtime)
SELECT id, title, type, description, release_year, age_certification, runtime
FROM staging_movies;
-- Insert into the relation tables: movie_genres & movie_countries


/*
DATABASE TESTING
*/
-- 1. Show all movies along with their genres and production countries
SELECT 
    m.id,
    m.title,
    mg.genre,
    mc.country
FROM movies m
LEFT JOIN movie_genres mg ON m.id = mg.movie_id
LEFT JOIN movie_countries mc ON m.id = mc.movie_id;

-- 2. The most popular movie genre
SELECT genre, COUNT(*) AS total
FROM movie_genres
GROUP BY genre
ORDER BY total DESC
LIMIT 1;

-- 3. Country with the highest film production
SELECT country, COUNT(*) AS total
FROM movie_countries
GROUP BY country
ORDER BY total DESC
LIMIT 1;