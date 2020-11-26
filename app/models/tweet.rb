class Tweet < ApplicationRecord
    ## Seria de esta forma pero como no tenemos una asociacion entre las tablas Tweet y User, esto no es necesario
    #belongs_to :user
    validates :twittear, presence: true
    validates :username, presence: true

    has_and_belongs_to_many :tags

    after_create do
        @tweet = Tweet.find_by(id: self.id)
        hashtags = self.twittear.scan(/#\w+/) 
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            @tweet.tags << tag
        end
    end

    before_update do
        tweet = Tweet.find_by(id: self.id)
        tweet.tags.clear
        hashtags = self.twittear.scan(/#\w+/) 
        hashtags.uniq.map do |hashtag|
            tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'))
            tweet.tags << tag
        end
    end
end
