module Judge
  class JudgeController < BaseController
    before_action :authenticate_user!
    layout 'judge/application'

    def load_feedback_data(activity); end
  end
end
