class AuthenticateController < ApplicationController

  def show
    render json: @user
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:uuid, :website_id)
  end
end
