class TeamsController < MatchesController
  before_action :user_is_admin?
  before_action :user_has_permission?, only: [:show]
  before_action :valid_users_invitations?, only: [:create]

  def new
    redirect_to match_team_path(@match, current_user.current_team) if current_user.current_team
    @team = Team.new
    @team.name = "#{Spicy::Proton.adjective}_#{Spicy::Proton.noun}"
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      invite_users
      current_user.teams << @team
      flash[:notice] = t('team.messages.created')
      redirect_to match_main_index_path(@match)
    else
      flash.now[:alert] = t('team.messages.error_creating')
      render 'new'
    end
  end

  def show
    @team = Team.friendly.find(params[:id])
  end

  private

  def team_params
    params.require(:team)
          .permit(:name)
          .merge(match_id: params[:match_id])
  end

  def invite_users
    params[:user_invitations].each do |email_input|
      user = User.find_by_email(email_input)
      if user.nil?
        User.invite!({ email: email_input[1] }, current_user)
      elsif user.email != current_user.email
        user.teams << @teams
      end
    end
  end

  def valid_users_invitations?
    user1 = User.new(email: params[:user_invitations][:email_1])
    user2 = User.new(email: params[:user_invitations][:email_2])
    return if (user1.can_be_invited? || user1.email.empty?) && (user2.can_be_invited? || user2.email.empty?)

    flash[:alert] = t('team.messages.error_users')
    redirect_to new_match_team_path(@match)
  end
end
