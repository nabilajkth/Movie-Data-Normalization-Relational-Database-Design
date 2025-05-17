#  Building a Relational Database System for Streaming Movie Data Using PostgreSQL

Building a Relational Database System for Streaming Movie Data Using PostgreSQL

---

## Project Description:
This project aims to normalize movie data from the movies.csv dataset, design an Entity-Relationship Diagram (ERD), and build a relational database system using PostgreSQL. Initially unstructured data is transformed into a structured format and separated into three main tables based on normalization principles (up to 3NF). A staging table is created as temporary storage, and the data is then inserted into the main tables using DDL and DML techniques. This project also includes writing SQL queries for data exploration and database validation.

---

## Dataset Description

The original dataset movies.csv contains the following columns:

|Column Name|Data type|Description|
|---|---|---|
|id|VARCHAR|Unique identifier for each movie|
|title|VARCHAR/TEXT|Movie title|
|type|VARCHAR/TEXT|Content type (e.g., movie, show|
|description|VARCHAR/TEXT|Movie synopsis|
|release_year|INTEGER|Year of release|
|age_certification|VARCHAR/TEXT|Age rating|
|runtime|INTEGER|Duration in minutes|
|genre|ARRAY OF TEXT|List of genres|
|production_countries|ARRAY OF TEXT|List of production countries|

---

## Project Steps
1. Create Database and Staging Table
	•	Create a database to store the movie data.
	•	Create a staging_movies table to temporarily hold raw data from the CSV file.
	•	Load the CSV file into staging_movies using the COPY command.

2. Normalize the Data
	•	Normalize data up to 3NF by splitting arrays into separate tables.
	•	Final schema consists of:
	•	movies — main table for movie metadata.
	•	movie_genres — many-to-many relation between movies and genres.
	•	movie_countries — many-to-many relation between movies and production countries.

3. Create Final Tables with DDL

Use CREATE TABLE statements to define:
	•	movies
	•	movie_genres (with foreign key referencing movies)
	•	movie_countries (with foreign key referencing movies)

4. Insert Cleaned Data with DML

Use INSERT INTO ... SELECT and UNNEST() to populate normalized tables from the staging table.

5. Query for Data Exploration

Run sample queries for database testing:
	•	Show all movies with their genres and production countries.
	•	Find the most popular genre.
	•	Find the country that produces the most movies.
 
---

## Notes
- Make sure to store the CSV file in the correct path:
  * Windows: C:\tmp\movies.csv
  * Mac/Linux: /tmp/movies.csv
- Ensure PostgreSQL is properly installed and running.
   
---

## Author
•	Name: Nabila Sulistiowati

