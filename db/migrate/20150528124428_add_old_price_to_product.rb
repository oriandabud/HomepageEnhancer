class AddOldPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :old_price, :integer
    add_column :products, :regular_price, :integer
    add_column :product_pages, :regular_price_selector, :string
  end
end
