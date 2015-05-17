class PageViewController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_product , only: [:create ]
  before_action :set_user , only: [:create ]

  # POST /websites
  # POST /websites.json
  def create
    @popularity = @product.popularities.where(user: @user).first
    @popularity = Popularity.create(user: @user , product: @product , entrances: 0) if @popularity.nil?
    @popularity.update_attribute( 'entrances', @popularity.entrances+1)

    render nothing: true, status: 204
  end

  private

  def set_product
    @product = Product.find_by_page_link(params[:url])
    unless @product
      url = params[:url]
      doc = Nokogiri::HTML(open(url))
      website = Website.find_by_url(params[:website])
      title = doc.at_css(website.page_product_name_selector).text
      picture_link = doc.at_css(website.page_product_picture_selector).src
      Product.create(page_link: params[:url],picture_link: picture_link, title: title)
    end

  end

  def set_user
    @user = User.find_by_id(params[:user]) || User.create(uuid: params[:user])
  end
end
