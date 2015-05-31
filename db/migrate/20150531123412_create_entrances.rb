class CreateEntrances < ActiveRecord::Migration
  def change
    create_table :entrances do |t|
      t.references :popularity, index: true
      t.timestamps null: false
    end
    add_foreign_key :entrances, :popularities

    add_column :popularities, :entrances_count, :integer , default: 0
    remove_column :popularities, :entrances
  end
end
