# Main controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  def after_sign_up_path_for; end
end
