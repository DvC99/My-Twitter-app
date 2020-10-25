class TweetsController < ApplicationController
  before_action :authenticate_user!,only: [:home]#ESTE ES PARA SABER SI ESTA LOGUEADO
  
  def index
    if user_signed_in?
      redirect_to home_path
    end
  end
  def home
    @tweets = Tweet.all.order("created_at DESC")
    @tweet = Tweet.new
    @user = current_user.username
    @CountTweets = Tweet.where(:username => current_user.username).count
    @users = User.where("username !=:username", username: current_user.username)  
  end

  def profile
    @tweets = Tweet.where(:username => params[:username]).order("created_at DESC")
    @user = params[:username]
    @CountTweets = Tweet.where(:username => current_user.username).count
    @users = User.where("username !=:username", username: current_user.username) 
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def new
    @tweet = Tweet.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def create
    current_username = { "username": current_user.username }
    @tweet = Tweet.new(current_username.merge(tweet_params))
    if @tweet.save
      flash[:success] = "Tweet was successfully created"
      redirect_to home_path
    else
        flash[:error] = "Something went wrong"
        render :new
    end
  end

  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        flash[:success] = "Tweet was successfully updated"
        redirect_to home_path
      else
          flash[:error] = "Something went wrong"
          render :new
      end
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    flash[:success] = "Tweet successfully deleted"
    redirect_to home_path
  end

  private
    def tweet_params
      params.require(:tweet).permit(:twittear)
    end
end
