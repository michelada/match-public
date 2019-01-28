module Admin
  class AdminController < ApplicationController
    before_action :user_is_admin

    def user_is_admin
      redirect_to root_path if current_user.role != 'admin'
    end
  end
end
