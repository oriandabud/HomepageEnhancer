class User < ActiveRecord::Base
  belongs_to :website
  has_many :popularities ,-> {order(entrances: :desc)}
  has_many :products, :through => :popularities

  def self.create_with_website(user_params , website)
    user_params[:website_id] = @website.id
    User.create(user_params)
  end

end
