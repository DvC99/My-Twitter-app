class TweetsController < ApplicationController
  before_action :authenticate_user!,only: [:home]#ESTE ES PARA SABER SI ESTA LOGUEADO
  
  def index
    if user_signed_in?
      redirect_to home_path
    end
  end
  def home
    @tweets = Tweet.where(username: User.where("username =:username", username: current_user.username ).select(:username).or(User.where(id: Follow.select(:followee_id).where("follower_id =:follower_id",  follower_id:current_user.id)).select(:username))).order("created_at DESC")
    @user = current_user.username
    @CountTweets = Tweet.where(:username => current_user.username).count
    @CountFollowers = Follow.where("followee_id =:followee_id",  followee_id:current_user.id).count#seguidor
    @CountFollowing = Follow.where("follower_id =:follower_id",  follower_id:current_user.id).count#seguido
    @users = User.where("username !=:username", username: current_user.username)
 end
  def profile
    @tweets = Tweet.where(:username => params[:username]).order("created_at DESC")
    @CountTweets = Tweet.where(:username => :username).count
    @userProfile=User.find_by(username:  params[:username])
    @CountFollowers = Follow.where("followee_id =:followee_id",  followee_id:@userProfile.id).count#seguidor
    @CountFollowing = Follow.where("follower_id =:follower_id",  follower_id:@userProfile.id).count#seguido
    @users = User.where("username !=:username", username: current_user.username)
  end
  def Followers
    @user = current_user.username
    @userProfile = User.find_by(username:  params[:username])
    @users2 = User.where(id: Follow.select(:follower_id).where("followee_id =:followee_id",  followee_id:@userProfile.id))
    @CountTweets = Tweet.where(:username => @userProfile.username).count
    @CountFollowers = Follow.where("followee_id =:followee_id",  followee_id:@userProfile.id).count#seguidor
    @CountFollowing = Follow.where("follower_id =:follower_id",  follower_id:@userProfile.id).count#seguido
    @users = User.where("username !=:username", username: current_user.username)
  end
  def Following
    @user = current_user.username
    @users = User.where("username !=:username", username: current_user.username)
    @userProfile = User.find_by(username:  params[:username])
    @users2 = User.where(id: Follow.select(:followee_id).where("follower_id =:follower_id",  follower_id:@userProfile.id))
    @CountTweets = Tweet.where(:username => @userProfile.username).count
    @CountFollowers = Follow.where("followee_id =:followee_id",  followee_id:@userProfile.id).count#seguidor
    @CountFollowing = Follow.where("follower_id =:follower_id",  follower_id:@userProfile.id).count#seguido
    
  end
  def follow
    @user = User.find(params[:id])
    current_user.followees << @user
    redirect_back(fallback_location: root_path)
  end
  def unfollow
    @user = User.find(params[:id])
    current_user.followed_users.find_by(followee_id: @user.id).destroy
    redirect_back(fallback_location: root_path)
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