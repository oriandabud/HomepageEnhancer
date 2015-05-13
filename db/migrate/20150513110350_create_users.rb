class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uuid
      t.references :website, index: true

      t.timestamps null: false
    end
    add_foreign_key :users, :websites
  end
end
