class TeamInvitationsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(params[:email])
    if !user&.team && valid_email(params[:email])
      User.invite!({ email: params[:email] }, current_user)
      flash[:notice] = t('team.messages.user_invited')
      redirect_to match_team_path(@match, current_user.team)
    else
      flash[:alert] = t('team.messages.error_inviting')
      redirect_to new_team_invitation_path
    end
  end

  private

  def valid_email(email)
    email.match?(/~*@michelada.io\z/i.freeze)
  end
end
