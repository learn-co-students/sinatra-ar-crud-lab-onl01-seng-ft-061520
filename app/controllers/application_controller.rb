require_relative '../../config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :root
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    @article = Article.new
    erb :form
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :form
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  post '/articles' do
    # binding.pry
    Article.create(params[:article])
    redirect "/articles/#{Article.last.id}"
  end

  delete '/articles/:id/delete' do
    @article = Article.find(params[:id])
    @article.destroy
    redirect to '/index'
  end

  patch '/articles/:id' do
    article = Article.find(params[:id])
    article.update(params[:article])
    redirect "/articles/#{article.id}"
  end
end
