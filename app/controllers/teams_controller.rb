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
    if validate_user && @team.save 
      current_user.update_attribute(:team, @team)
      unless invite_users(params[:user_invitation_1][:email]) && invite_users(params[:user_invitation_2][:email])
        flash[:alert] = "Alguno de los usuarios ya tiene un equipo"
      else
        flash[:notice] = t('team.messages.created')
      end
      redirect_to main_index_path
    else
      flash[:alert] = t('team.messages.error_creating')
      render new_team_path
    end
  end

  def show
    @team = Team.find_by(id: params[:id])
    @activities = Activity.team_activities(params[:id])
    @my_activities = Activity.user_activities(current_user.id)
    @team_score = Activity.team_activities_score(params[:id])
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end

  def invite_users user_email
    team_id = current_user.team_id
    user = User.find_by(email: user_email)

    unless user_email.empty?
      unless user.nil?
        if user.team.nil?
          user.update_attributes(team_id: team_id)
        else
          return false
        end
      else
        User.invite!({ email: user_email }, current_user)
        new_user = User.find_by_email(user_email)
        new_user&.update_attributes(team_id: current_user.team_id, role: User.roles[:user])
      end
    end

    return true
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
end
