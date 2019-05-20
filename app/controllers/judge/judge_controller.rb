module Judge
  class JudgeController < MatchesController
    before_action :authenticate_user!
    before_action :user_is_judge
    layout 'application'

    def user_is_judge
      return if current_user.judge?

      flash[:alert] = t('activities.messages.not_permitted')
      redirect_to root_path
    end
  end
end
