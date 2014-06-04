require 'pry'
require 'sinatra'
require_relative 'methods'

get '/' do
  @page = params[:page].to_i
  @content = display_all_articles(@page)
  @content.count
  erb :index
end

get '/articles' do
  erb :show
end

get '/articles/:id' do
  @article_id = params[:id]
  @article = select_article(@article_id)
  @comment = display_comment
  erb :article
end

post '/articles/posts' do
  unless params["title"] == '' || params["url"] == ''
    save_article(params["title"], params["url"], params["description"])
  end
  redirect '/'
end

post '/articles/:id/comment' do
  article_id = params[:id]
  article_comment = params["comment"]
  unless article_comment == ''
    save_comment(article_id, article_comment)
  end
  display_comment
  redirect "/articles/#{article_id}"
end
#add title search
