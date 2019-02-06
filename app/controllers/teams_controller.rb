class TeamsController < ApplicationController
  before_action :user_is_valid
  VALID_EMAIL_REGEX = /~*@michelada.io/i.freeze

  def new
    redirect_to team_path(current_user.team) unless current_user.team.nil?
    @team = Team.new
    @name = "#{Spicy::Proton.adjective}_#{Spicy::Proton.noun}"
  end

  def create
    @team = Team.new(team_params)
    @name = params[:team][:name]
    if validate_user && users_invitable && @team.save
      current_user.update_attribute(:team, @team)
      flash[:notice] = t('team.messages.created') if invite_users(params[:user_invitation_1][:email]) && invite_users(params[:user_invitation_2][:email])
      redirect_to main_index_path
    else
      flash[:alert] = t('team.messages.error_creating')
      render new_team_path
    end
  end

  def show
    user_has_permission
    @team = Team.find_by(id: params[:id])
    @activities = Activity.team_activities(params[:id])
    @my_activities = Activity.user_activities(current_user.id)
    @team_score = Activity.team_activities_score(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def invite_users(user_email)
    team_id = current_user.team_id
    user = User.find_by(email: user_email)
    return true if user_email.empty?

    if user.nil?
      User.invite!({ email: user_email }, current_user)
      User.find_by_email(user_email).update_attributes(team_id: current_user.team_id, role: User.roles[:user])
    elsif user.team.nil?
      user.update_attributes(team_id: team_id)
    else
      return false
    end
  end

  def users_invitable
    user1 = User.find_by(email: params[:user_invitation_1][:email])
    user2 = User.find_by(email: params[:user_invitation_2][:email])
    return true if !user1&.team && !user2&.team

    false
  end

  def validate_user
    user1 = params[:user_invitation_1][:email]
    return false if !user1.empty? && !user1.match(VALID_EMAIL_REGEX)

    user2 = params[:user_invitation_2][:email]
    return false if !user2.empty? && !user2.match(VALID_EMAIL_REGEX)

    true
  end

  def user_is_valid
    redirect_to root_path if current_user.role == 'admin'
  end

  def user_has_permission
    return if current_user.team.id == params[:id].to_i

    flash[:alert] = t('team.error_accessing')
    redirect_to root_path
  end
end
