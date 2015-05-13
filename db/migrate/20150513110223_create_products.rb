class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :page_link
      t.string :picture_link
      t.string :title
      t.references :website, index: true

      t.timestamps null: false
    end
    add_foreign_key :products, :websites
  end
end
