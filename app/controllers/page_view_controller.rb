class PageViewController < ApplicationController
  require 'open-uri'
  skip_before_filter :verify_authenticity_token
  before_action :set_product , only: [:create ]
  before_action :set_user , only: [:create ]
  before_action :set_popularity , only: [:create ]

  # POST /websites
  # POST /websites.json
  def create
    @popularity.update_attribute( 'entrances', @popularity.entrances+1) if @popularity

    render nothing: true, status: 204
  end

  private

  def set_product
    @product = Product.find_by_page_link(params[:url]) || Product.create_using_crawler(params[:url] , Website.find_by_url(params[:website]))
  end

  def set_user
    @user = User.find_by_uuid(params[:user]) || User.create(uuid: params[:user])
  end

  def set_popularity
    @popularity = @product.popularities.where(user: @user).first || Popularity.create(user: @user , product: @product , entrances: 0) if @product
  end
end
