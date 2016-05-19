class AddFriendshipToFollower < ActiveRecord::Migration
  def change
    add_column :followers, :friendship, :boolean
  end
end
