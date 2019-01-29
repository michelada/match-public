module Admin
  class UserManagerController < AdminController
    def index
      @users = User.all_except_actual(current_user.id)
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(role: user_params[:role])
        flash[:notice] = t('user.role_updated')
      else
        flash[:alert] = t('user.error_updating_role')
      end
      redirect_to admin_user_manager_index_path
    end

    private

    def user_params
      params.require(:user).permit(:role)
    end
  end
end
