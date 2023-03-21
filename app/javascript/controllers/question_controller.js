import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["next", "all", "step"]

  connect() {
    // something on connection is flashing before the following. 
    this.forms = document.getElementsByClassName("tab")
    this.randomTabIndex = Math.floor(Math.random() * this.forms.length)
    this.forms[this.randomTabIndex].classList.remove("d-none")
    this.forms[this.randomTabIndex].classList.add("show")
    this.steps = document.getElementsByClassName("step")
    this.stepCounter = 0
    this.reg = /[_^].+/
  }

  next(event) {
    this.steps[this.stepCounter].classList.remove("active") 
    this.stepCounter += 1
    this.steps[this.stepCounter].classList.add("active")
    let answeredPartial = document.getElementsByClassName("show")
    if ((this.forms.length) == 2) { event.target.style.display = 'none' }
    answeredPartial[0].classList.add("d-none")
    answeredPartial[0].classList.remove("tab", "show")
    let forms = document.getElementsByClassName("tab")
    let randomTabIndex = Math.floor(Math.random() * forms.length)
    forms[randomTabIndex].classList.remove("d-none")
    forms[randomTabIndex].classList.add("show")
  }

  // Can be added to use a previous button
  // previous(event) {
  // }

  select(event) {
    let longID = event.target.parentElement.firstChild.nextSibling.id
    let id = longID.replace(this.reg, "")
    if (id == "colour") { this.allButtons = document.getElementsByClassName("colour-btn") }
    if (id == "mood") { this.allButtons = document.getElementsByClassName("checkbox-emoji") }
    if (id == "decade") { this.allButtons = document.getElementsByClassName("checkbox-element-decade") }
    Array.from(this.allButtons).forEach((button) => {
      if (button.id != longID) { button.parentElement.classList.add("d-none") }
    })
    if ((this.forms.length) == 1) {
      let answeredPartial = document.getElementsByClassName("show")[0]
      answeredPartial.classList.add("d-none")
      document.getElementById("step-box").classList.add("d-none")
    }
  }

  // To be built out to allow user to switch effectively by clicking on the step indicators
  // switch(event) {
  //   let currentStep = document.getElementsByClassName("active")[0]
  //   currentStep.classList.remove("active")
  //   event.target.classList.add("active")
  //   console.log()
  // }
}
