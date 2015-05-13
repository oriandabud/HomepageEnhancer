class CreatePopularities < ActiveRecord::Migration
  def change
    create_table :popularities do |t|
      t.integer :entrances , default: 0
      t.references :user, index: true
      t.references :product, index: true

      t.timestamps null: false
    end
    add_foreign_key :popularities, :users
    add_foreign_key :popularities, :products
  end
end
