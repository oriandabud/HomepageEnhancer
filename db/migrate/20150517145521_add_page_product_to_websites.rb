class AddPageProductToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :page_product_picture_selector, :string
    add_column :websites, :page_product_name_selector, :string
    add_column :websites, :page_product_price_selector, :string
    add_column :websites, :product_price_selector, :string
    add_column :products, :price, :integer
  end
end
