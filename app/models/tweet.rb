class Tweet < ApplicationRecord
    ## Seria de esta forma pero como no tenemos una asociacion entre las tablas Tweet y User, esto no es necesario
    #belongs_to :user

    validates :twittear, presence: true
    validates :username, presence: true
end
