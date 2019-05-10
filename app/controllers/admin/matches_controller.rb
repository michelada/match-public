module Admin
  class MatchesController < AdminController
    before_action :set_match, only: [:show, :edit, :update, :destroy]
    def index
      @matches = Match.all
    end

    def show; end

    def new
      @match = Match.new
    end

    def create
      @match = Match.new(match_params)
      if @match.save
        flash[:notice] = t('match.create')
        redirect_to admin_matches_path
      else
        flash[:alert] = @match.errors.full_messages.first
        render 'new'
      end
    end

    def edit; end

    def update
      if @match.update(match_params)
        flash[:notice] = t('match.update')
        redirect_to admin_matches_path
      else
        flash[:error] = @match.errors.full_messages.first
        render 'edit'
      end
    end

    def destroy
      if @match.destroy
        flash[:notice] = t('match.delete')
      else
        flash[:error] = t('match.error_deleting')
      end
      redirect_to admin_matches_path
    end

    private

    def match_params
      params.require(:match).permit(:match_type, :start_date, :end_date)
    end

    def set_match
      @match = Match.find(params[:id])
    end
  end
end
