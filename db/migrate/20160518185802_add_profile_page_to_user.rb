class AddProfilePageToUser < ActiveRecord::Migration
  def change
    add_column :users, :profile_page, :string
  end
end
