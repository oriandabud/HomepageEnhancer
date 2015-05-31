class Popularity < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  has_many :entrances  , counter_cache: true

  scope :by_entrances ,-> {order(entrances_count: :desc)}
end
