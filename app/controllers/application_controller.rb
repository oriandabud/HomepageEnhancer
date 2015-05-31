class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery
  before_filter :set_cors_headers
  before_action :set_website
  before_action :set_user

  respond_to :json

  def set_website
    @current_website = Website.find_by_name(params[:website_id])
  end

  def set_user
    @current_user = User.find_by_uuid(params[:uuid]) || User.create!(uuid: params[:uuid] , website: @current_website)
  end

  private

  def set_cors_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  end
end
