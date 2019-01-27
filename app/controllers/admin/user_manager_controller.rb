module Admin
  class UserManagerController < AdminController
    def index
      @users = User.all_except_actual(current_user.id)
    end

    def update
      @user = User.find(params[:id])
      @user.role = user_params[:role]
      if @user.update_attributes(role: user_params[:role])
        flash[:notice] = 'Role actualizado'
      else
        flash[:alert] = 'Error actualizando'
      end
      redirect_to admin_user_manager_index_path
    end

    private

    def user_params
      params.require(:user).permit(:role)
    end
  end
end
