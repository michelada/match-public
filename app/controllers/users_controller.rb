class UsersController < MatchesController
  def update
    @team = Team.find(current_user.current_team&.id)
    if current_user.teams.delete(@team)
      verify_team_members
      flash[:notice] = t('team.messages.left')
      redirect_to match_main_index_path(@match)
    else
      flash[:alert] = t('team.messages.error_leaving')
      redirect_to teams_path(current_user.current_team&.team_id)
    end
  end

  private

  def verify_team_members
    return if @team.users.any? || @team.project

    @team.destroy
  end
end
