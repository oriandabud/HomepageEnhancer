class RecommendationController < ApplicationController

  def index
    respond_with @current_website, user_id: @current_user.id
  end

end
