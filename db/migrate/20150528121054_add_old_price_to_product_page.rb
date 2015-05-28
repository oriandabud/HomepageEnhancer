class AddOldPriceToProductPage < ActiveRecord::Migration
  def change
    add_column :product_pages, :old_price_selector, :string
    add_column :home_pages, :product_old_price_selector, :string
    add_column :home_pages, :product_container_selector, :string
  end
end
