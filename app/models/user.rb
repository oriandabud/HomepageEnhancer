class User < ActiveRecord::Base
  belongs_to :website
  has_many :popularities ,-> {order(entrances: :desc)}
  has_many :products, :through => :popularities

end
