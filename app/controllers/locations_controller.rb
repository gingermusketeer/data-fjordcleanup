class LocationsController < ApplicationController
  skip_before_action :authenticate_access!, only: [:popup]
  before_action :setup_form_data, only: [:edit, :update]

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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @location.update(location_params)
      redirect_to locations_url
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def location_params
    result = params.require(:location).permit(:name, :geojson, :kind)
    result[:geojson] = JSON.parse(result[:geojson])
    result
  end

  def setup_form_data
    @location = Location.find(params[:id])
  end
end
