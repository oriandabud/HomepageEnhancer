class RemoveSelectorsFromWebsites < ActiveRecord::Migration
  def change
    remove_column :websites , :product_name_selector
    remove_column :websites , :product_url_selector
    remove_column :websites , :product_picture_selector
    remove_column :websites , :product_price_selector
    remove_column :websites , :page_product_picture_selector
    remove_column :websites , :page_product_name_selector
    remove_column :websites , :page_product_price_selector

  end
end
