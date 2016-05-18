class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.integer :user_id
      t.datetime :mention_time

      t.timestamps null: false
    end
  end
end
