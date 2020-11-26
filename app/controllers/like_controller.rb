class LikeController < ApplicationController
    
    def create
        like = Like.new(username_id:current_user.username , tweet_id:params[:id])
        if like.save
            redirect_back(fallback_location: root_path)
        else
            flash[:register_errors] = like.errors.full_messages
            redirect_back(fallback_location: root_path)
        end
    end
    
    def destroy
        like = Like.find_by("username_id =:username_id", username_id: current_user.username, tweet_id:params[:id])
        like.destroy
        redirect_back(fallback_location: root_path)
    end
end
