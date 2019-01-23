class LocationsController < ApplicationController
  def new
  end

  def create
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
