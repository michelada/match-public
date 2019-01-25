module Judge
  class JudgeController < ActionController::Base
    before_action :authenticate_user!
    before_action :iser_is_judge
    layout 'judge/application'

    def load_feedback_data(activity); end

    def user_is_judge
      redirect_to root_path if current_user.role != 2
    end
  end
end
