class UsersController < MatchesController
  def update
    @team = Team.find(current_user.team_id)
    if current_user.update_attribute(:team, nil)
      verify_team_members
      flash[:notice] = t('team.messages.left')
      redirect_to match_main_index_path(@match)
    else
      flash[:alert] = t('team.messages.error_leaving')
      redirect_to teams_path(ccurrent_user.team_id)
    end
  end

  private

  def verify_team_members
    return if @team.users.any? || !@team.project.nil?

    @team.destroy
  end
end
