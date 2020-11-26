class CommentController < ApplicationController
    def create
        @comment = Comment.new(username_id: current_user.username, tweet_id: params[:tweet_id], comment: params[:comment][:comment])
        if @comment.save
            redirect_back(fallback_location: root_path)
        else
            flash[:register_errors] = comment.errors.full_messages
            redirect_back(fallback_location: root_path)
        end
    end
    
    def destroy
        @comment = Comment.find_by("username_id =:username_id", username_id: current_user.username, tweet_id:params[:id])
        @comment.destroy
        redirect_to home_path
    end
end
