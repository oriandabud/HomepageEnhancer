class PageViewController < ApplicationController
  # include Factory

  skip_before_filter :verify_authenticity_token

  before_action :products , only: [:create ]
  before_action :update_popularities , only: [:create ]


  # POST /websites
  # POST /websites.json
  def create
    render nothing: true, status: 204
  end

  private

  def products
    @products = product ||
                ::Factory::ViewAble.generate(params[:url] , @current_website)
  end

  def product
    product = Product.find_by_page_link(params[:url])
    product = product ? [product] : nil
  end


  def update_popularities
    @products.each do |product|
      product.popularities.where(user: @current_user).empty? ?
          Popularity.create(user: @current_user , product: product , entrances: 1) :
          product.popularities.where(user: @current_user).first.increment!(:entrances)
    end if @products
  end
end
