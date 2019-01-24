module Judge
  class JudgeController < ApplicationController
    before_action :authenticate_user!
    layout 'judge/application'

    def load_feedback_data(activity); end
  end
end
