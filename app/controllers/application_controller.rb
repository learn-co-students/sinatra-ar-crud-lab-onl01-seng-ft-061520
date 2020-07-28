
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end
  
  patch '/articles/:id' do
    #binding.pry
    @article = Article.find_by_id(params[:id])
    @article.update(params[:article])
    
    redirect to "/articles/#{@article.id}"
    
  end

  post '/articles' do
    @article = Article.create(title: params[:article][:title], content: params[:article][:content])
    #binding.pry
    redirect to "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find_by_id(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find_by_id(params[:id])
    erb :edit
  end

  delete '/articles/:id' do
    Article.destroy(params[:id])
    redirect to '/articles'
  end  
end
