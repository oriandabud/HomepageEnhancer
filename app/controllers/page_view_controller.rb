class PageViewController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_action :set_products , only: [:create ]


  # POST /websites
  # POST /websites.json
  def create
    Product.update_popularities @products ,@current_user
    render nothing: true, status: 204
  end

  private

  def set_products
    @products = Product.find_by_page_link(params[:url]) ? [Product.find_by_page_link(params[:url])] : nil ||
                Product.products_scrap_array(params[:url] , @current_website)
  end
end
