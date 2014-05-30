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

get '/submit' do
  erb :show
end


post '/posts' do
  save_article(params["title"], params["url"], params["description"])
  # binding.pry
  redirect '/'
end
