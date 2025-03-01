/*
=================================================
Graded Challenge 1

Nama  : Nabila Sulistiowati
Batch : CODA-RMT-003

=================================================
*/

-- CREATE TABLE Movies (
--     id VARCHAR(100),
--     title TEXT,
--     type TEXT,
-- 	   description VARCHAR,
-- 	   release_year TEXT,
-- 	   age_certification VARCHAR(15),
-- 	   runtime INTEGER,
-- 	   genre TEXT[],
-- 	   production_countries TEXT[]
-- );

-- Tabel Staging
-- COPY Movies(id, title, type, description, release_year, age_certification, runtime, genre, production_countries)
-- FROM '/private/tmp/movies.csv'
-- DELIMITER ','
-- CSV HEADER;

-- ALTER TABLE Movies
-- ALTER COLUMN release_year TYPE INTEGER USING release_year::integer;

-- ALTER TABLE Movies
-- RENAME COLUMN id TO movie_id;


-- Normalisasi Data

-- Create table GC1_movies
-- CREATE TABLE GC1_movies (
--     movie_id SERIAL PRIMARY KEY,
--     title TEXT,
--     release_year INT,
--     runtime INT
-- );

-- Create table genres
-- CREATE TABLE genres (
--     genre_id SERIAL PRIMARY KEY,
--     movie_id INT REFERENCES GC1_movies(movie_id),
--     genre TEXT
-- );


-- Create table production_countries
-- CREATE TABLE production_countries (
--     country_id SERIAL PRIMARY KEY,
--     movie_id INT REFERENCES GC1_movies(movie_id),
--     production_country TEXT
-- );

-- -- Insert data to GC1_movies
-- INSERT INTO GC1_movies (title, release_year, runtime)
-- SELECT title, release_year, runtime
-- FROM Movies;

-- SELECT movie_id::INTEGER, unnest(genre)
-- FROM Movies;

-- -- Insert data to genres
-- INSERT INTO genres (movie_id, genre)
-- SELECT movie_id, unnest(genre)
-- FROM Movies;

-- -- Insert data to production_countries
-- INSERT INTO production_countries (movie_id, production_country)
-- SELECT movie_id, unnest(string_to_array(production_countries, ','))
-- FROM Movies;

