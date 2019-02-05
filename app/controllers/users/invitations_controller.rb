# Adding function to invitation controller.
#
module Users
  class InvitationsController < Devise::InvitationsController
    after_action :update_user_account, only: [:create]
    def update_user_account
      @user = User.find_by_email(params[:user][:email])
      if @user.team.nil?
        @user&.update_attributes(team_id: current_user.team_id, role: User.roles[:user])
      end
    end
  end
end
