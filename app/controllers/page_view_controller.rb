class PageViewController < ApplicationController
  # include Factory

  skip_before_filter :verify_authenticity_token

  before_action :products , only: [:create ]
  before_action :user , only: [:create ]
  before_action :update_popularities , only: [:create ]


  # POST /websites
  # POST /websites.json
  def create
    puts "inside create"

    render nothing: true, status: 204
  end

  private

  def products
    @products = product ||
                ::Factory::ViewAble.generate(params[:url] , Website.find_by_name(params[:website]))
  end

  def product
    product = Product.find_by_page_link(params[:url])
    product = product ? [product] : nil
  end

  def user
    @user = User.find_by_uuid(params[:user]) || User.create(uuid: params[:user])
  end

  def update_popularities
    @products.each do |product|
      popularity = product.popularities.where(user: @user).first || Popularity.create(user: @user , product: product , entrances: 0)
      popularity.update_attribute( 'entrances', popularity.entrances+1)
    end if @products
  end
end
