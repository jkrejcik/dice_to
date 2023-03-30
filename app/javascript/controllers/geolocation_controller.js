import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  maximumAge: 0,
};

// Connects to data-controller="geolocation"
export default class extends Controller {

  success(pos) {
    const crd = pos.coords;

    console.log("Your current position is:");
    console.log(`Latitude : ${crd.latitude}`);
    console.log(`Longitude: ${crd.longitude}`);
    console.log(`More or less ${crd.accuracy} meters.`);
    const input = document.querySelector("input[name=coordinates]");
    input.value = `${crd.latitude},${crd.longitude}`;
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

 connect() {
    navigator.geolocation.getCurrentPosition(this.success, this.error, options);
  }
}
