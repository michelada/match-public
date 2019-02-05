class TeamInvitationsController < ApplicationController
  def create
    render 
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def invite_users
    user1 = params[:user_invitation_1][:email]
    team_id = current_user.team_id
    User.find_by(email: user1).update_attribute(:team_id, team_id) if User.exists?(email: user1)
    User.invite!({ email: user1 }, current_user) unless user1.empty?
  end
end
