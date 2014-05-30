-- CREATE TABLE ARTICLES (
-- id SERIAL PRIMARY KEY,
-- title varchar(200) NOT NULL,
-- url text NOT NULL,
-- description varchar(250),
-- created_at timestamp NOT NULL
-- );


-- CREATE TABLE COMMENTS (
-- id SERIAL PRIMARY KEY,
-- article_id SERIAL,
-- body text NOT NULL,
-- created_at timestamp NOT NULL
-- );


-- *****************************************************
-- actions
-- INSERT INTO articles (title, url, description, created_at)
-- VALUES ('', '', '', now());
-- ******************************
-- queries

-- SELECT * FROM articles;
-- SELECT * FROM comments;
-- DELETE FROM articles WHERE ________;
-- UPDATE table_name SET column_name = new_value WHERE conditional_filter;
-- UPDATE articles SET title = This is way cool! WHERE id = 1;
