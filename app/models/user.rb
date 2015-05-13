class User < ActiveRecord::Base
  belongs_to :website
  has_many :popularities
  has_many :products, :through => :popularities
end
