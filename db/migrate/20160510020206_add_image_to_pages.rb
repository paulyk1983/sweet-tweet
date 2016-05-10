class AddImageToPages < ActiveRecord::Migration
  def change
    add_column :pages, :image, :text
  end
end
