import { Controller } from "@hotwired/stimulus"
import StarRating from "star-rating.js"

// Connects to data-controller="star-rating"
export default class extends Controller {
  connect() {
    new StarRating(this.element)
    console.log(this.element)
  }

  // submit() {
  //   console.log("Star rate submit")
  //   console.log(element)
  //   this.element.submit();
  // }
}
