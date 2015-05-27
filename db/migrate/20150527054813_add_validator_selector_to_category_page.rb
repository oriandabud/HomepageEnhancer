class AddValidatorSelectorToCategoryPage < ActiveRecord::Migration
  def change
    add_column :category_pages, :validator_selector, :string
  end
end
