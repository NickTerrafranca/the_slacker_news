require 'sinatra'
require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: 'slacker_news')
    yield(connection)
  ensure
    connection.close
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

get '/' do
  query = 'SELECT articles.id, articles.title, articles.url, articles.description
    FROM articles
    ORDER BY created_at
    LIMIT 20;'
  @content = db_connection do |conn|
    conn.exec(query)
  end
  erb :index
end

get '/articles' do
  erb :show
end

get '/articles/:id' do
  @article_id = params[:id]
  query = 'SELECT articles.id, articles.title, articles.url, articles.description
  FROM articles
  WHERE articles.id = $1;'
  result = db_connection do |conn|
    conn.exec_params(query, [@article_id])
  end

  @article = result.first
  erb :article
end

post '/posts' do
  save_article(params["title"], params["url"], params["description"])
  redirect '/'
end

post '/articles/:id/comment' do
  article_id = params[:id]
  article_comment = params["comment"]
  save_comment(article_id, article_comment)
  redirect "/articles/#{article_id}"
end
