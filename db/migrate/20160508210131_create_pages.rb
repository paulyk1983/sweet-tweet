class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :long_url
      t.string :short_url

      t.timestamps null: false
    end
  end
end
