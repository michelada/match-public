class FeedbackController < ApplicationController

  def create
    @comment = Feedback.new(feedback_params)
    if @comment.save
      flash[:notice] = 'Comentario guardado'
    else
      flash[:alert] = 'Comentarion no guardado'
    end
    redirect_to judge_activity_path(@comment)
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment, :activity_id)
  end
end
