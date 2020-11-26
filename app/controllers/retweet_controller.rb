class RetweetController < ApplicationController
    def create
        @retweet = Retweet.new(username_id: current_user.username, tweet_id: params[:tweet_id], tweet: params[:retweet][:retweet])
        if @retweet.save
            redirect_back(fallback_location: root_path)
        else
            flash[:register_errors] = retweet.errors.full_messages
            redirect_back(fallback_location: root_path)
        end
    end
    
    def destroy
        @retweet = Retweet.find_by(params[:id])
        @retweet.destroy
        redirect_to home_path
    end
end
