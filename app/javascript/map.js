import L from "https://cdn.skypack.dev/leaflet";

const CENTER = {
  lat: 59.90325104612689,
  lng: 10.729951858520508,
};

var map = L.map("map", {
  minZoom: 0,
  maxZoom: 18,
}).setView([CENTER.lat, CENTER.lng], 15);
window.mapObj = map;

var topolayer = new L.TileLayer.WMS(
  "https://opencache.statkart.no/gatekeeper/gk/gk.open",
  {
    layers: "norges_grunnkart",
    format: "image/png",
    transparent: false,
    version: "1.0",
    attribution: "Kartverket",
  }
).addTo(map);

var southWest = new L.LatLng(63.28735, 10.58363),
  northEast = new L.LatLng(63.63414, 11.78317),
  bounds = new L.LatLngBounds(southWest, northEast);

const features = JSON.parse(window.map.dataset.features);
var geojsonMarkerOptions = {
  radius: 8,
  fillColor: "#ff7800",
  color: "#000",
  weight: 1,
  opacity: 1,
  fillOpacity: 0.8,
};
L.geoJSON(features, {
  pointToLayer: function (feature, latlng) {
    var svg = `<svg version="1.1"
     baseProfile="full"
     width="300" height="200"
     xmlns="http://www.w3.org/2000/svg">

  <rect width="100%" height="100%" fill="red" />

  <circle cx="150" cy="100" r="80" fill="green" />

  <text x="150" y="125" font-size="60" text-anchor="middle" fill="white">SVG</text>

  </svg>`;
    var iconUrl = "data:image/svg+xml;base64," + btoa(svg);

    return L.marker(latlng, {
      icon: L.icon({
        iconUrl:
          "https://usercontent.one/wp/www.fjordcleanup.no/wp-content/uploads/2021/01/cropped-CC4A45DC-342D-4767-AA5C-230FA30069AE-e1610814643826.png",
        iconSize: [38, 50],
      }),
    });
    // return L.circleMarker(latlng, geojsonMarkerOptions);
  },
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
}).addTo(map);
