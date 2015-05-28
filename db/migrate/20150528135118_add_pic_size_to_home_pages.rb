class AddPicSizeToHomePages < ActiveRecord::Migration
  def change
    add_column :home_pages, :img_max_width, :string
    add_column :home_pages, :img_max_height, :string
  end
end
