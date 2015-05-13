class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :page_link
      t.references :website, index: true

      t.timestamps null: false
    end
    add_foreign_key :categories, :websites
  end
end
