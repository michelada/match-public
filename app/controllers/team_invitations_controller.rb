class TeamInvitationsController < ApplicationController
  VALID_EMAIL_REGEX = /~*@michelada.io/i.freeze

  def new; end

  def create
    if validate_user && invite_user
      flash[:notice] = t('team.messages.user_invited')
      redirect_to team_path(current_user.team)
    else
      redirect_to accept_user_invitation_path
    end
  end

  private

  def team_invitations_params
    params.permit(:email)
  end

  def invite_user
    user_email = params[:email]
    user = User.find_by(email: user_email)
    if user.nil?
      User.invite!({ email: user_email }, current_user)
      new_user = User.find_by(email: user_email)
      new_user.update_attributes(team_id: current_user.team_id, role: User.roles[:user])
    elsif user.team.nil?
      user.update_attributes(team_id: current_user.team_id)
    else
      flash[:alert] = t('activerecord.errors.models.user.attributes.email.already_has_team')
      return false
    end
  end

  def validate_user
    user_email = params[:email]
    if user_email.empty? || !user_email.match(VALID_EMAIL_REGEX)
      flash[:alert] = t('team.messages.email_not_valid')
      return false
    end
    true
  end
end
