require 'pry'
require 'sinatra'
require_relative 'methods'

get '/' do

  @content = display_all_articles
  erb :index
end

get '/articles' do
  erb :show
end

post '/articles/posts' do
  unless params["title"] = '' || params["url"] = '' || params["description"] = ''
    save_article(params["title"], params["url"], params["description"])
  end
  redirect '/'
end

get '/articles/:id' do
  @article_id = params[:id]
   @article = select_article(@article_id)
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


#add pagination
#add title search
