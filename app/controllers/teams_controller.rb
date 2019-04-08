class TeamsController < ApplicationController
  before_action :user_is_admin?
  before_action :user_has_permission?, only: [:show]
  before_action :valid_users_invitations?, only: [:create]

  def new
    redirect_to team_path(current_user.team) unless current_user.team.nil?
    @team = Team.new
    @team.name = "#{Spicy::Proton.adjective}_#{Spicy::Proton.noun}"
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      current_user.update_attribute(:team, @team)
      invite_users
      flash[:notice] = t('team.messages.created')
      redirect_to main_index_path
    else
      flash.now[:alert] = t('team.messages.error_creating')
      render new_team_path
    end
  end

  def show
    @team = Team.friendly.find(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def invite_users
    params[:user_invitations].each do |email|
      next if email[1].empty?

      User.invite!({ email: email[1] }, current_user)
    end
  end

  def valid_users_invitations?
    user1 = User.new(email: params[:user_invitations][:email_1])
    user2 = User.new(email: params[:user_invitations][:email_2])
    return if user1.can_be_invited? && user2.can_be_invited?

    flash[:alert] = t('team.messages.error_users')
    redirect_to new_team_path
  end
end
