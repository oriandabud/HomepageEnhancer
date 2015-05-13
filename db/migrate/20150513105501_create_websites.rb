class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :url
      t.string :name
      t.integer :num_of_products
      t.string :product_name_selector
      t.string :product_url_selector
      t.string :product_picture_selector

      t.timestamps null: false
    end
  end
end
