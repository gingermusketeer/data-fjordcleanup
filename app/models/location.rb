class Location < ApplicationRecord
  validates :name, :geojson, :kind, presence: true

  after_commit on: [:create, :update] do |location|
    geojson = location.geojson.deep_dup
    geojson.fetch("properties")["id"] = location.id
    geojson.fetch("properties")["kind"] = location.kind
    location.update_columns(geojson: geojson)
  end

  enum kind: {
    area: "area",
    event: "event",
    lobster_house: "lobster_house",
  }
end
