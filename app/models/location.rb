class Location < ApplicationRecord
  validates :name, :geojson, :kind, presence: true

  has_many :hosted_cleanups, class_name: "Cleanup", foreign_key: "hosted_at_id"
  has_and_belongs_to_many :cleanups

  after_commit on: [:create, :update] do |location|
    geojson = location.geojson.deep_dup
    geojson.fetch("properties")["id"] = location.id
    geojson.fetch("properties")["kind"] = location.kind
    location.update_columns(geojson: geojson)
  end

  enum kind: {
    cleaned: "cleaned",
    cleaning: "cleaning",
    planned: "planned",
    event: "event",
    lobster_house: "lobster_house",
  }
end
