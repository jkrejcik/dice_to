import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-submit"
export default class extends Controller {
  static targets = ["form"]

  connect() {
    // console.log(this.formTargets)
  }

  submit() {
    console.log("submit")
    console.log(element)
    this.element.submit();
  }

}
