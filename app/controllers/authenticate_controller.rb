class AuthenticateController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    render json: @user
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_uuid(user_params[:uuid]) || User.create(user_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:uuid, :website_id)
  end
end
