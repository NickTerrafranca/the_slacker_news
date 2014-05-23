require 'sinatra'
require 'csv'
require 'pry'
ARTICLES = 'articles.csv'

def read_article_data(file_name)
  articles = []
  CSV.foreach(file_name, headers: true, header_converters: :symbol) do |row|
    articles << row.to_hash
  end
  articles
end

get('/') do
  @data_in = read_article_data(ARTICLES)
  erb :index
end


post('/posts') do

 title = params[:title]
 url = params[:url]
 description = params[:description]

  CSV.open(ARTICLES, 'a') do |file|
    file << [title,url,description]
  end
  redirect '/'
end
