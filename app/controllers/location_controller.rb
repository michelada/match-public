class LocationController < ApplicationController
  def new
    respond_to do |format|
      format.js do
        @index = params[:index].to_i
        @activity = Activity.new
        @activity.locations.build
        render 'locations/new', layout: false
      end
    end
  end
end
