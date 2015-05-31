class RecommendationController < ApplicationController

  def index
    @recommandations = []
    @current_user.popularities.by_entrances.limit(@current_website.num_of_products).each {|p| @recommandations << p.product} if @current_user

    respond_with @recommandations, meta: {
                                     num_of_products: @current_website.num_of_products,
                                     home_page: @current_website.home_page,
                                 }
  end

end
