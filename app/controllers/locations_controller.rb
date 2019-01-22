class LocationsController < ApplicationController
  def new
    @location = Location.new
  end

  def create(name)
    @location = Location.build(name)
    if @location.save
      redirect_to new_activity_path
      flash[:notice] = 'Location added succesfully'
    else
      flash[:alert] = 'Something went wrong D:'
      render 'new'
    end
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
