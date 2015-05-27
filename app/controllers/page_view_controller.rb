class PageViewController < ApplicationController
  require 'open-uri'
  skip_before_filter :verify_authenticity_token
  before_action :set_products , only: [:create ]
  before_action :set_user , only: [:create ]
  before_action :set_popularity , only: [:create ]

  # POST /websites
  # POST /websites.json
  def create
    render nothing: true, status: 204
  end

  private

  def set_products
    @products = [Product.find_by_page_link(params[:url])] ||
                Factory::ViewAble.new(params[:url] , Website.find_by_name(params[:website]))
  end

  def set_user
    @user = User.find_by_uuid(params[:user]) || User.create(uuid: params[:user])
  end

  def set_popularity
    @products.each do |product|
      popularity = product.popularities.where(user: @user).first || Popularity.create(user: @user , product: product , entrances: 0)
      popularity.update_attribute( 'entrances', popularity.entrances+1)
    end
  end
end
