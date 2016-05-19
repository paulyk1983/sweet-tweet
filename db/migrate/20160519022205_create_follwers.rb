class CreateFollwers < ActiveRecord::Migration
  def change
    create_table :follwers do |t|
      t.integer :user_id
      t.string :name
      t.string :profile_image
      t.string :profile_page

      t.timestamps null: false
    end
  end
end
