class InvitationController < DeviseInvitable::RegistrationsController
  after_action :update_user_role, only: [:create]

  def update_user_role
    current_user.update_attributes(role: 0)
  end
end
