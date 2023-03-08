import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["template", "target", "plus", "minus"]

  connect() {
    console.log(this.templateTarget.plusTarget)
  }

  add(event) {
    // console.log(this.targetTarget)
    this.plusTarget.classList.add("d-none")
    this.minusTarget.classList.remove("d-none")
    this.targetTarget.insertAdjacentHTML("beforeend", this.templateTarget.innerHTML )
  }

  remove(event) {
    // console.log(this.targetTarget)
    // this.targetTarget.removeAdjacentHTML("beforeend", this.templateTarget.innerHTML)
    this.targetTarget.remove(this.templateTarget.innerHTML)
  }


}
