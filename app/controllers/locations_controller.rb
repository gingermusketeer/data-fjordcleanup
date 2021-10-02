class LocationsController < ApplicationController
  skip_before_action :authenticate_access!, only: [:popup]

  def popup
    @location = Location.find(params[:id])
    render "#{@location.kind}_popup", layout: false
  end

  def index
    @locations = Location.all
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to :root
    else
      render :new
    end
  end

  private

  def location_params
    result = params.require(:location).permit(:name, :geojson)
    result[:geojson] = JSON.parse(result[:geojson])
    result
  end
end
