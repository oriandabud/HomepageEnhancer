class Product < ActiveRecord::Base
  belongs_to :website
  has_many :popularities
  has_many :users, :through => :popularities

  def self.update_popularities products , user
    products.each do |product|

      popularity = product.popularities.where(user: user).first || Popularity.create!(user: user , product: product)

      Entrance.create!(popularity: popularity)
    end
  end


  def self.products_scrap_array(url , website)
    ::Scrapper.scrap_products url , website
  end
end
