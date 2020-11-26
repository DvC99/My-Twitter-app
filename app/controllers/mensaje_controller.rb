class MensajeController < ApplicationController
    def create
        @mensaje = Mensaje.new(envia_id: current_user.id, recibe_id: params[:id], mensaje: params[:mensaje][:mensaje])
        if @mensaje.save
            redirect_back(fallback_location: root_path)
        else
            flash[:register_errors] = mensaje.errors.full_messages
            redirect_back(fallback_location: root_path)
        end
    end
    
    def destroy
        @mensaje = Mensaje.find_by(params[:id])
        @mensaje.destroy
        redirect_to home_path
    end

    def mensaje
        @user = current_user.username
        @CountTweets = Tweet.where(:username => current_user.username).count
        @CountFollowers = Follow.where("followee_id =:followee_id",  followee_id:current_user.id).count#seguidor
        @CountFollowing = Follow.where("follower_id =:follower_id",  follower_id:current_user.id).count#seguido
        @users = User.where("username !=:username", username: current_user.username)
        @userProfile = User.find_by(username: current_user.username)
        @seguidores = User.where(id: Follow.select(:follower_id).where("followee_id =:followee_id",  followee_id:@userProfile.id)).or(User.where(id: Follow.select(:followee_id).where("follower_id =:follower_id",  follower_id:@userProfile.id)))
        #@seguidores = User.where(id: Follow.select(:followee_id).where("follower_id =:follower_id",  follower_id:@userProfile.id))
    end
    def privado
        @user = current_user.username
        @CountTweets = Tweet.where(:username => current_user.username).count
        @CountFollowers = Follow.where("followee_id =:followee_id",  followee_id:current_user.id).count#seguidor
        @CountFollowing = Follow.where("follower_id =:follower_id",  follower_id:current_user.id).count#seguido
        @users = User.where("username !=:username", username: current_user.username)
        @userProfile = User.find_by(username: current_user.username)
        @mensajes = (Mensaje.where("envia_id =:envia_id",  envia_id:current_user.id).where("recibe_id =:recibe_id",  recibe_id:params[:id]).or(Mensaje.where("recibe_id =:recibe_id",  recibe_id:current_user.id).where("envia_id =:envia_id",  envia_id:params[:id]))).order("created_at ASC")
        @userChat = User.find(params[:id])
    end
end
