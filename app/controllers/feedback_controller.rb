class FeedbackController < ApplicationController
  def new
  end

  private 

  def feedback_params
    params.require(:feedback).permit(:comment, :activity_id)
  end
end
