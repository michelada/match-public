module Judge
  class JudgeController < MatchesController
    before_action :authenticate_user!
    before_action :load_match
    before_action :user_is_judge
    layout 'application'

    def user_is_judge
      redirect_to main_index_path if current_user.role != 'judge'
    end

    def load_match
      @match = Match.last
    end
  end
end
