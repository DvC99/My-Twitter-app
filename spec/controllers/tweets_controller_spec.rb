require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
############################---CREATE TWIITER----###########################################
    context "Cuando se intintda crear in Tweet con parametros invalidos" do
        it "Debería volver a renderizar el nuevo formulario Tweet" do
        expect { Tweet.create! }.to raise_error(ActiveRecord::RecordInvalid)
        end 
    end
    context "Cuando el usuario esta logeado" do        
        let(:user) { create(:user) }    
        before do
            sign_in user
            post :create, params: {  tweet: { twittear: "This is a test" } }
        end    
        it "debería crear un nuevo Tweet" do
            expect(Tweet.last.twittear).to eq("This is a test")
        end
        it "debería redirigir al índice de Tweets" do
            expect(subject).to redirect_to home_path
        end
    end    
    context "Cuando el ussuario no esta logeado" do
        let(:user) { create(:user) }
        before do
            sign_in user
            post :create, params: { tweet: { twittear: "This is a test" } }
        end    
        it "debe redirigir a la página de inicio de sesión del usuario" do
            expect(subject).to redirect_to home_path
        end
    end
############################---DELETED TWIITER----###########################################
    context "Cuando el usuario esta logeado e intenta borrar un Tweet" do        
        let(:user) { create(:user) }    
        before do
            sign_in user
            tweets = Tweet.where(:username => user)
            tweets.each do |tweet| 
                if tweet.username == user.username
                    delete :destroy, :id => tweet
                end

                it "debería eliminar un tweet" do
                    expect(tweet).to eq("This is a test")
                end

                it "debería redirigir al índice de Tweets" do
                    expect(subject).to redirect_to home_path
                end
            end
        end        
    end 

    context "Cuando el usuario no esta logeado e intenta borrar un Tweet" do
        let(:user) { create(:user) }
        before do
            tweets = Tweet.where(:username => user)
            tweets.each do |tweet| 
                if tweet.username == user.username
                     ddelete :destroy, :id => tweet
                end

                it "debe redirigir a la página de inicio de sesión del usuario" do
                    expect(subject).to redirect_to home_path
                end
            end
        end    
        
    end 
############################---SHOW TWEETS----###########################################
    context "Cuando el usuario esta logeado e intenta listar los tweets" do        
        let(:user) { create(:user) }    
        before do
            sign_in user
            get :home
        end
        it "No debería listar o mostrar un nil" do
            expect(assigns(:tweets)).to_not be_nil
        end
    end
############################---SHOW Followers----###########################################
    context "Cuando el usuario esta logeado e intenta mostrar los seguidores" do        
        let(:user) { create(:user) }    
        before do
            sign_in user
            get :Followers, params: {username: user.username}
        end 
        
        it "No debería listar o mostrar un nil" do
            expect(assigns(:users2)).to_not be_nil
        end
    end
############################---SHOW Following----###########################################
    context "Cuando el usuario esta logeado e intenta mostrar los seguidos" do        
        let(:user) { create(:user) }    
        before do
            sign_in user
            get :Following, params: {username: user.username}
        end 
        
        it "No debería listar o mostrar un nil" do
            expect(assigns(:users2)).to_not be_nil
        end
    end
############################---Follow----###########################################
    context " Cuando se intenta seguir a alguien con parametros invalidos" do
        it "Debería volver a renderizar denuevo el formulario de Seguidores" do
        expect { Follow.create! }.to raise_error(ActiveRecord::RecordInvalid)
        end 
    end
    context "Cuando el usuario esta logeado" do        
        let(:user) { create(:user) }    
        before do
            sign_in user
            post :follow, params: {id: user.id}
        end    
        it "Debería crear un@ nueva Seguidor@" do
            expect(Follow.last.follower_id).to eq(user.id)
        end
        it "debería redirigir al índice de seguidores" do
            expect(subject).to redirect_to root_path
        end
    end 
##   NO SE PEUDE SEGUIR A ALGUIEN SI NO SE ESTA LOGUEADO
#    context "When user is NOT logged in" do
#        let(:user) { create(:user) }
#        before do
#            sign_in user
#            post :follow, params: {id: user.id}
#        end    
#        it "should redirect to user sign in page" do
#            expect(subject).to redirect_to root_path
#        end
#    end  

end
