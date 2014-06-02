require 'pry'
require 'sinatra'
require_relative 'methods'

get '/' do
  display_all_articles(@content)
  erb :index
end

get '/articles' do
  erb :show
end

post '/articles' do
  save_article(params["title"], params["url"], params["description"])
  redirect '/'
end

get '/articles/:id' do
   select_article(@article_id, @article)
   @comment = display_comment
  erb :article
end

post '/articles/:id/comment' do
  article_id = params[:id]
  article_comment = params["comment"]
  save_comment(article_id, article_comment)
  display_comment
  redirect "/articles/#{article_id}"
end
