class CleanupController < ApplicationController
  def new
    @hosted_at = Location.find(params[:location_id])
    @locations = Location.area
    @cleanup = Cleanup.new
  end
end
