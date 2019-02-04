module Judge
  class LocationsController < ApplicationController
    def update
      @activity = Activity.find(params[:activity_id])
      @location = @activity.locations.where('id = ?', params[:id]).first
      @location.update_attributes(approve: !@location.approve)
      redirect_to judge_activity_path(@activity)
    end
  end
end
