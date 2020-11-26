class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.string  :username_id
      t.integer :tweet_id
      
      t.timestamps
    end
  end
end
