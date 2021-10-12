import { Controller } from "@hotwired/stimulus";
import L from "https://cdn.skypack.dev/leaflet";
import "https://cdn.skypack.dev/@geoman-io/leaflet-geoman-free";

export default class MapController extends Controller {
  static targets = ["container", "store"];

  connect() {
    this.containerTarget.style.height = window.innerHeight - 120 + "px";
    const CENTER = {
      lat: 59.90325104612689,
      lng: 10.729951858520508,
    };

    var map = L.map(this.containerTarget, {
      minZoom: 0,
      maxZoom: 18,
    }).setView([CENTER.lat, CENTER.lng], 15);
    window.map = map;

    const data = JSON.parse(this.storeTarget.value);
    const layer = L.geoJSON(data).addTo(map);

    new L.TileLayer.WMS("https://opencache.statkart.no/gatekeeper/gk/gk.open", {
      layers: "norges_grunnkart",
      format: "image/png",
      transparent: false,
      version: "1.0",
      attribution: "Kartverket",
    }).addTo(map);

    map.pm.addControls({
      position: "topleft",
      drawCircle: false,
    });

    map.on("pm:drawend", (shape) => {
      const layers = [];
      map.eachLayer((layer) => {
        layers.push(layer);
      });
      const result = layers
        .filter(({ pm }) => pm)
        .map((layer) => layer.toGeoJSON())[0];
      this.storeTarget.value = JSON.stringify(result);
    });

    layer.on("pm:update", ({ layer }) => {
      this.storeTarget.value = JSON.stringify(layer.toGeoJSON());
    });
  }
}
