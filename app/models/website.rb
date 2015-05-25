class Website < ActiveRecord::Base
  has_many :users
  has_many :products

  has_one :home_page
  has_one :product_page
  has_one :category_page
end
