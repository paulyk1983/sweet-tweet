class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.integer :retweets_count
      t.integer :favorites_count
      t.text :image
      t.text :message
      t.datetime :tweet_time

      t.timestamps null: false
    end
  end
end
