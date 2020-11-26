class CreateRetweets < ActiveRecord::Migration[6.0]
  def change
    create_table :retweets do |t|
      t.string  :username_id
      t.integer :tweet_id
      t.string  :tweet

      t.timestamps
    end
  end
end
