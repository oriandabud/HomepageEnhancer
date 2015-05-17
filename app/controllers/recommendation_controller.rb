class RecommendationController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_user, only: [:show]
  before_action :set_website, only: [:show]

  def show
    # @website.num_of_products
    # @products = @user.popularities.limit(@website.num_of_products)
    # @products += @website.products.limit(@product.length -@website.num_of_products)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    # @user = User.find_by_uuid(user_params[:uuid])
  end

  def set_website
    # @website = Website.find_by_url(user_params[:url])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def recommendation_params
    # params.permit(:uuid , :url , :homepage)
  end
end
