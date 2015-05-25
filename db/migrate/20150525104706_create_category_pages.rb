class CreateCategoryPages < ActiveRecord::Migration
  def change
    create_table :category_pages do |t|
      t.references :website
      t.string :products_selector

      t.timestamps null: false
    end
  end
end
