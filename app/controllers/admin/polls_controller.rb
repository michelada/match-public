module Admin
  class PollsController < AdminController
    def index
      @polls = Poll.all
      redirect_to new_poll_path
    end

    def new
      @poll = Poll.new
    end

    def edit
      @poll = Poll.find(params[:id])
    end

    def create
      @poll = Poll.new(poll_params)
      if @poll.save
        flash[:notice] = t('poll.created')
        redirect_to admin_polls_path
      else
        flash[:aleert] = t('poll.error_creating')
        render 'new'
      end
    end

    def show
      binding.pry
      Poll.votes_in_activities(params[:id])
      @poll = Poll.find(params[:id])
    end

    def update
      @poll = Poll.find(params[:id])
      if @poll.update(poll_params)
        flash[:notice] = t('polls.updated')
        redirect_to admin_polls_path
      else
        flash[:alert] = t('polls.error_updating')
        render 'edit'
      end
    end

    def destroy
      @poll = Poll.find(params[:id])
      if @poll.destroy
        flash[:notice] = t('polls.deleted')
      else
        flash[:alert] = t('polls.erorr_deleting')
      end
      redirect_to admin_polls_path
    end

    private

    def poll_params
      params.require(:poll).permit(:end_date, :start_date)
    end
  end
end
