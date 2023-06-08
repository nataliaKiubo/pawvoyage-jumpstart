// import { Controller } from "@hotwired/stimulus"

// export default class extends Controller {
//   static values = {
//     apiKey: String,
//     markers: Array
//   }

//   connect() {
//     mapboxgl.accessToken = this.apiKeyValue;
//     this.map = new mapboxgl.Map({
//       container: this.element, // container ID
//       style: 'mapbox://styles/mapbox/streets-v12' // style URL
//     });
//     this.#addMarkersToMap();
//   }

//   #addMarkersToMap() {
//     this.markersValue.forEach(marker => {
//       new mapboxgl.Marker()
//         .setLngLat([marker.lng, marker.lat])
//         .addTo(this.map);
//     });
//   }
// }

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
    this.map = new mapboxgl.Map({
      container: this.element, // container ID
      style: 'mapbox://styles/mapbox/streets-v12' // style URL
    });
    this.#addMarkersToMap();
    this.#fitMapToMarkers();
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds();
    this.markersValue.forEach(marker =>
      bounds.extend([marker.lng, marker.lat]));

    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15 });
  }

  #addMarkersToMap() {
    const markers = this.markersValue;
    markers.forEach(marker => {
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(this.map);
    });
  }
}
