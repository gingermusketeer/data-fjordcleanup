import L from "https://cdn.skypack.dev/leaflet";

const CENTER = {
  lat: 59.90825104612689,
  lng: 10.723051858520508,
};

var map = L.map("map", {
  minZoom: 0,
  maxZoom: 18,
}).setView([CENTER.lat, CENTER.lng], 16);
window.mapObj = map;

new L.TileLayer.WMS("https://opencache.statkart.no/gatekeeper/gk/gk.open", {
  layers: "norges_grunnkart",
  format: "image/png",
  transparent: false,
  version: "1.0",
  attribution: "Kartverket",
}).addTo(map);

const features = JSON.parse(window.map.dataset.features);
window.features = features;
const layer = L.geoJSON(features, {
  onEachFeature: function (f, l) {
    let loading = false;

    function onMapClick(e) {
      if (loading) {
        return;
      }
      loading = true;
      l.bindPopup("Loading...").openPopup();
      const { id } = f.properties;
      fetch(`/locations/${id}/popup`)
        .then((data) => data.text())
        .then((html) => {
          l.bindPopup(html).openPopup();
        })
        .catch((e) => {
          console.error(e);
        })
        .then(() => {
          loading = false;
        });
    }

    l.on("click", onMapClick);
  },
});

map.addLayer(layer);

let overlayMaps = {
  Layers: layer,
};

L.control.layers(null, overlayMaps).addTo(map);
