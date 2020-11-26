class Like < ApplicationRecord
    validates :tweet_id, uniqueness: { scope: :username_id }
end
