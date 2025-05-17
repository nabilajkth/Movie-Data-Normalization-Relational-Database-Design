/*
MEMBUAT TABEL STAGING
Untuk menyimpan data mentah langsung dari CSV sebelum dinormalisasi.
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
LOADING DATA movies.csv YANG AKAN DIMUAT KE TABEL
*/
COPY staging_movies(id, title, type, description, release_year, age_certification, runtime, genre, production_countries)
FROM '/private/tmp/movies.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM staging_movies

/*
NORMALISASI DATA
Struktur database mencapai bentuk 3NF (Third Normal Form), meminimalkan redudansi dan memisahkan entitas
*/

/*1. Tabel movies (tabel utama)
Menyimpan data film inti (tanpa array).
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
2. Tabel movie_genres (relasi many-to-many)
*/
CREATE TABLE movie_genres (
    movie_id VARCHAR REFERENCES movies(id),
    genre TEXT,
    PRIMARY KEY(movie_id, genre)
); 
-- Satu film bisa memiliki banyak genre.
-- Normalisasi array genre[] menggunakan UNNEST():
INSERT INTO movie_genres (movie_id, genre)
SELECT id, UNNEST(genre)
FROM staging_movies;


/*
3. Tabel movie_countries (relasi many-to-many)
*/
CREATE TABLE movie_countries (
    movie_id VARCHAR REFERENCES movies(id),
    country TEXT,
    PRIMARY KEY(movie_id, country)
);
-- Satu film bisa diproduksi oleh lebih dari satu negara.
-- Normalisasi array production_countries[] menggunakan:
INSERT INTO movie_countries (movie_id, country)
SELECT id, UNNEST(production_countries)
FROM staging_movies;

/*
MEMASUKAN DATA KE TABEL FINAL
*/
-- Masukkan ke tabel utama
INSERT INTO movies (id, title, type, description, release_year, age_certification, runtime)
SELECT id, title, type, description, release_year, age_certification, runtime
FROM staging_movies; -- Error
-- Masukkan ke tabel relasi: movie_genres & movie_countries sudah dijelaskan di atas


/*
PENGUJIAN DATABASE
*/
-- 1. Menampilkan semua film dengan genre dan negara produksinya
SELECT 
    m.id,
    m.title,
    mg.genre,
    mc.country
FROM movies m
LEFT JOIN movie_genres mg ON m.id = mg.movie_id
LEFT JOIN movie_countries mc ON m.id = mc.movie_id;

-- 2. Genre film yang paling populer
SELECT genre, COUNT(*) AS total
FROM movie_genres
GROUP BY genre
ORDER BY total DESC
LIMIT 1;

-- 3. Negara yang paling banyak membuat film
SELECT country, COUNT(*) AS total
FROM movie_countries
GROUP BY country
ORDER BY total DESC
LIMIT 1;