class RootController < ApplicationController
  skip_before_action :authenticate_access!, only: [:map, :login]

  def index
    @features = load_features
  end

  def map
    @features = load_features
    render layout: "map"
  end

  def login
    if params[:login_token] == ENV.fetch("LOGIN_TOKEN")
      session[:logged_in] = true
      redirect_to root_path
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def load_features
    features = Location.all.pluck(:geojson)
    {
      type: "FeatureGroup",
      features: features,
    }
  end
end
