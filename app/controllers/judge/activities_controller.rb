module Judge
  class ActivitiesController < ApplicationController
    def index
      @actioities = Activity.all
    end
  end
end
