class AddTwitterIdToFollower < ActiveRecord::Migration
  def change
    add_column :followers, :twitter_id, :string
  end
end
