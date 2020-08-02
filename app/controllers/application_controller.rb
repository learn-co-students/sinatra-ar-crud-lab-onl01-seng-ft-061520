require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get'/articles/new' do
    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/:id' do
    id = params[:id]
    @article = Article.find(id)
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  post '/articles' do
    title = params[:title]
    content = params[:content]
    data = {:title => title, :content => content}
    @article = Article.create(data)
    url = '/articles/' + @article.id.to_s
    redirect to(url)
  end

  patch '/articles/:id' do
    title = params[:title]
    content = params[:content]
    @article = Article.find(params[:id])
    @article.title = title.split(" ").map do |word|
      word.capitalize()
    end
    @article.title = @article.title.join(" ")
    @article.content = content
    @article.save
    url = '/articles/' + @article.id.to_s
    redirect to(url)

  end

  delete '/articles/:id' do
    article = Article.find(params[:id])
    article.destroy
    redirect to('/articles')
  end
end
