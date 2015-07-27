
require './config/environment'
require './app/models/tweet'
require './app/models/user'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "flatiron2"
  end
  
  helpers do
    
    def signed_in?
      session[:user_id]
    end
   
    def current_user
      current_user = User.find(session[:user_id])
    end
    
    def error 
      session[:error]
    end
    
  end
  get '/' do
    @signin_page = false
    @tweets = Tweet.all
    @users = User.all
    erb :index
  end

  get '/tweet' do
    @signin_page = false
    @user = User.find_by(:id => session[:user_id])
    erb :tweet
  end

  post '/tweet' do
    Tweet.create(:user_id => params[:user_id], :status => params[:status])
    redirect '/'
  end

  get '/users' do
    @signin_page = true
    erb :users
  end

  post '/sign-up' do
    @user = User.new(:name => params[:name], :email => params[:email])
    @user.save
    redirect '/'
  end

  post '/sign-in' do
    @user = User.find_by(:name => params[:name], :email => params[:email])
    if @user
      session[:user_id] = @user.id
    end
    session[:user_id]
    redirect '/tweet'
  end
  
  get '/sign-out' do
    @signin_page = true
    session[:user_id] = nil
    session[:error] = nil
    redirect '/'
  end
  
end