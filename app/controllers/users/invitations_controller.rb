# Adding function to invitation controller.
#
module User
  class InvitationsController < Devise::InvitationsController
    after_action :update_user_account, only: [:create]

    def update_user_account
      @user = User.find_by_email(params[:user][:email])
      @user.update_attribute(:team_id, current_user.team_id)
    end
  end
end
