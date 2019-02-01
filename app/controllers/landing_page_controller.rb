class LandingPageController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    redirect_to main_index_path unless current_user.nil?
  end
end
