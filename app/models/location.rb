class Location < ApplicationRecord
  after_commit do |location|
    geojson = location.geojson.deep_dup
    geojson.fetch("properties")["id"] = location.id
    location.update_columns(geojson: geojson)
  end
end
