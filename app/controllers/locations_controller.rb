class LocationsController < ApplicationController
  layout false

  def popup
    @location = Location.find(params[:id])
  end
end
