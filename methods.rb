require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'slacker_news')
    yield(connection)
  ensure
    connection.close
  end
end



def display_all_articles
  query = 'SELECT articles.id, articles.title, articles.url, articles.description, articles.created_at
  FROM articles
  ORDER BY created_at DESC
  LIMIT 15;'
  content = db_connection do |conn|
    conn.exec(query)
  end
end

def select_article(article_id)
  query = 'SELECT articles.id, articles.title, articles.url, articles.description
  FROM articles
  WHERE articles.id = $1;'
  result = db_connection do |conn|
    conn.exec_params(query, [@article_id])
  end
  article = result.first
end

def display_comment
  query = 'SELECT article_id, body, created_at
  FROM comments
  WHERE article_id = $1;'
  result = db_connection do |conn|
    conn.exec_params(query, [@article_id])
  end
end

def save_article(title, url, description)
  sql = "INSERT INTO articles (title, url, description, created_at)" +
  "VALUES ($1, $2, $3, NOW());"
  connection = PG.connect(dbname: 'slacker_news')
  connection.exec_params(sql, [title, url, description])
  connection.close
end

def save_comment(article_id, body)
  sql = "INSERT INTO comments (article_id, body, created_at)" +
  "VALUES ($1, $2, NOW());"
  connection = PG.connect(dbname: 'slacker_news')
  connection.exec_params(sql, [article_id, body])
  connection.close
end
