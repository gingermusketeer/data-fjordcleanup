class RootController < ApplicationController
  skip_before_action :authenticate_access!, only: [:map, :login]

  def index
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
    Location.group(:kind)
      .pluck(:kind, "json_agg(geojson)")
      .to_h
      .transform_values do |features|
      {
        type: "FeatureGroup",
        features: features,
      }
    end
  end
end
