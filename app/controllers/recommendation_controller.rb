class RecommendationController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :set_user, only: [:show]
  before_action :set_website, only: [:show]

  def show
    respond_with @website, user_id: @user.id
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_uuid(params[:uuid])
  end

  def set_website
    @website = Website.find_by_name(params[:id])
  end
end
