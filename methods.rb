require 'pg'

def db_connection
  begin
    connection = PG.connect(dbname: 'slacker_news')
    yield(connection)
  ensure
    connection.close
  end
end

def search_articles(params_query, page_param)
  page = page_param
  query = "SELECT articles.id, articles.title, articles.url, articles.description
  FROM articles
  WHERE articles.title ILIKE $1
  LIMIT 15
  OFFSET (15 * #{page});"
  result = db_connection do |conn|
    conn.exec_params(query, ["%#{params_query}%"])
  end
end

def display_all_articles(page_param)
  page = page_param
  query = "SELECT articles.id, articles.title, articles.url, articles.description, articles.created_at
  FROM articles
  ORDER BY created_at DESC
  LIMIT 15
  OFFSET (15 * #{page});"
  content = db_connection do |conn|
    conn.exec(query) #exec_params
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
