class CreateHomePages < ActiveRecord::Migration
  def change
    create_table :home_pages do |t|
      t.references :website
      t.string :product_name_selector
      t.string :product_url_selector
      t.string :product_price_selector
      t.string :product_picture_selector

      t.timestamps null: false
    end
  end
end
