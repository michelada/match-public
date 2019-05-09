class TeamInvitationsController < MatchesController
  before_action :verify_user, only: [:create]
  before_action :user_can_invite?, only: [:create]

  def new; end

  def create
    if invite_user
      flash[:notice] = t('team.messages.user_invited')
      redirect_to match_team_path(@match, current_user.current_team)
    else
      flash[:alert] = t('team.messages.error_inviting')
      redirect_to new_match_team_invitation_path(@match)
    end
  end

  private

  def invite_user
    user = User.find_by_email(@user.email)
    if user.nil?
      User.invite!({ email: params[:email] }, current_user)
    else
      user.teams << current_user.current_team
    end
  end

  def verify_user
    @user = User.new(email: params[:email])
    return if @user.can_be_invited?

    flash[:alert] = t('team.invalid_user')
    redirect_to new_match_team_invitation_path(params[:match_id])
  end

  def user_can_invite?
    return redirect_to root_path unless current_user&.current_team

    return if current_user.current_team.users.count < 3

    flash[:alert] = t('team.messages.error_limit_members')
    redirect_to match_team_path(@match, current_user.current_team)
  end
end
