class RootController < ApplicationController
  def index
    @features = load_features
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
