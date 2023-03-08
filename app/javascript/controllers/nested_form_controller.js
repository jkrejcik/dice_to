import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["template", "target"]

  connect() {
  }

  add(event) {
    console.log(this.templateTarget.value)
    this.targetTarget.insertAdjacentHTML("beforeend", this.templateTarget.innerHTML)
  }

  remove(event) {
    console.log(this.targetTarget)
    // this.targetTarget.removeAdjacentHTML("beforeend", this.templateTarget.innerHTML)
    this.targetTarget.remove(this.templateTarget.innerHTML)
  }
}
