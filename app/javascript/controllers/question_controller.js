import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["next"]

  connect() {
    // something on connection is flashing before the following. 
    this.forms = document.getElementsByClassName("tab")
    this.randomTabIndex = Math.floor(Math.random() * this.forms.length)
    this.forms[this.randomTabIndex].classList.remove("d-none")
    this.forms[this.randomTabIndex].classList.add("show")
    this.reg = /[_^].+/
  }

  next(event) {
    let answeredPartial = document.getElementsByClassName("show")
    if ((this.forms.length - 1) == 0) {
      event.target.style.display = 'none'
      this.forms[0].classList.add("d-none")
    }
    else {
      answeredPartial[0].classList.add("d-none")
      answeredPartial[0].classList.remove("tab", "show")
      let forms = document.getElementsByClassName("tab")
      let randomTabIndex = Math.floor(Math.random() * forms.length)
      forms[randomTabIndex].classList.remove("d-none")
      forms[randomTabIndex].classList.add("show")
    }
  }

  select(event) {
    let longID = event.target.parentElement.firstChild.nextSibling.id
    let id = longID.replace(this.reg, "")
    if (id == "colour") { this.allButtons = document.getElementsByClassName("colour-btn") }
    if (id == "mood") { this.allButtons = document.getElementsByClassName("checkbox-emoji") }
    if (id == "decade") { this.allButtons = document.getElementsByClassName("checkbox-element-decade") }
    Array.from(this.allButtons).forEach((button) => {
      if (button.id != longID) {
        button.parentElement.classList.add("d-none")
      }
    })
  }


  // select(event) {
  //   // identify with htmlFor
  //   console.log(event.target.htmlFor)
  //   let emojis = this.emojiTargets
  //   console.log(emojis)
  //   emojis.forEach((element, index) => {
  //     if (element.htmlFor = event.target.htmlFor) {
  //         emojis.splice((index + 1), index)
  //     }
  //     // else {
  //     //   element.attributes[1] = filter: saturate(50%);
  //     // }
  //   })
  // }
}
