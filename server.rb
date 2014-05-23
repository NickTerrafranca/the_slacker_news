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

get('/article/:title') do
  title = params[:title]
  article_data = read_article_data(ARTICLES)
  @article = []
  article_data.each do |a|
    if a[:title] == title
      @article << a
    end
    @article
  end
  erb :article
end

post('/posts') do
  title = params[:title]
  url = params[:url]
  description = params[:description]

  CSV.open(ARTICLES, 'a') do |file|
  file << [title, url, description]
  end
  redirect '/'
end
