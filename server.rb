require 'pry'
require 'sinatra'
require_relative 'methods'

get '/' do
  @page = params[:page].to_i
  @content = display_all_articles(@page)
  # @content.count #????
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

post '/articles' do
  if params["title"] == '' || params["url"] == ''
    @content_error = "Please complete the form fields"
    redirect '/articles?error=Please+complete+the+form+fields'
  else
    save_article(params["title"], params["url"], params["description"])
    redirect '/'
  end
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

get '/search' do
  @page = params[:page].to_i
  article_query = params[:query]
  @search_result = search_articles(article_query, @page).to_a
  erb :search_results
end

  get '/login' do
  erb :login_page
end

# Format article and comment time

# Display number of comments

# If I specify an invalid URL, I receive an error message,
#   and the submission form is re-rendered with the details I have
#   previously submitted.

# If I specify a url that has already been submitted, I receive an
#   error message, and the submission form is re-rendered with the
#   details I have previously submitted.

# Article url shortener
