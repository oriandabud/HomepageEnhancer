class CreateProductPages < ActiveRecord::Migration
  def change
    create_table :product_pages do |t|
      t.references :website
      t.string :name_selector
      t.string :picture_selector
      t.string :price_selector
      t.string :validator_selector

      t.timestamps null: false
    end
  end
end
