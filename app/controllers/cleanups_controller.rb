class CleanupsController < ApplicationController
  before_action :setup_form_data, only: [:new, :edit]

  def index
    @cleanups = Cleanup.all
  end

  def new
    @cleanup = Cleanup.new(occurred_on: DateTime.current)
  end

  def create
    @cleanup = Cleanup.new(cleanup_params)
    if @cleanup.save
      redirect_to cleanups_path
    else
      setup_form_data
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cleanup = Cleanup.find(params[:id])
  end

  def update
    @cleanup = Cleanup.find(params[:id])
    if @cleanup.update(cleanup_params)
      redirect_to cleanups_path
    else
      setup_form_data
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def setup_form_data
    @area_location_data = Location.area.pluck(:name, :id)
    @event_location_data = Location.event.pluck(:name, :id)
  end

  def cleanup_params
    params.require(:cleanup).permit(:occurred_on, :weight, :hosted_at_id, location_ids: [])
  end
end
