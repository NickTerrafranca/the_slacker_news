CREATE TABLE ARTICLES (
id SERIAL PRIMARY KEY,
title varchar(200) NOT NULL,
url text NOT NULL,
description varchar(250),
created_at timestamp NOT NULL
);


CREATE TABLE COMMENTS (
id SERIAL PRIMARY KEY,
article_id integer NOT NULL,
body text NOT NULL,
created_at timestamp NOT NULL
);

SELECT articles.id, articles.title, articles.url, articles.description
    FROM articles
    ORDER BY created_at
    LIMIT 20;

SELECT articles.id, articles.title, articles.url, articles.description
  FROM articles
  WHERE articles.id = $1;

SELECT article_id, body, created_at
    FROM comments
    WHERE article_id = 1;


  "INSERT INTO articles (title, url, description, created_at)" +
    "VALUES ($1, $2, $3, NOW());"

    "INSERT INTO comments (article_id, body, created_at)" +
    "VALUES ($1, $2, NOW());"



*****************************************************
actions
INSERT INTO articles (title, url, description, created_at)
VALUES ('', '', '', now());
******************************
queries

SELECT * FROM articles;
SELECT * FROM comments;
DELETE FROM articles WHERE ________;
UPDATE table_name SET column_name = new_value WHERE conditional_filter;
UPDATE articles SET title = This is way cool! WHERE id = 1;


