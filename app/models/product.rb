class Product < ActiveRecord::Base
  belongs_to :website
  has_many :popularities
  has_many :users, :through => :popularities

end
