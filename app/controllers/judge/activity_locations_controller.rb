module Judge
  class ActivityLocationsController < ApplicationController
    def update
      @activity = Activity.find(params[:activity_id])
      binding.pry
      @activity_location = @activity.locations.where('location_id = ?', params[:id])
      @activity_location.update_attribute(:approve, !@activity_location.approve)
      redirect_to judge_activity_path(@activity)
    end
  end
end
