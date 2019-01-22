class ApisController < ApplicationController
    def index
      @sum  = Activity.all
      @sum += Team.all
      
      
      respond_to do |format|
        format.html
        format.json { render json: @sum}
      end
    end
end
