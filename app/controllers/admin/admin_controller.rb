module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :user_is_admin?
    layout 'admin/application'

    def user_is_admin?
      redirect_to root_path unless current_user.admin?
    end
  end
end
