import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="question"
export default class extends Controller {
  static targets = ["next", "emoji"]

  connect() {
    this.forms = document.getElementsByClassName("tab")
    this.randomTabIndex = Math.floor(Math.random() * this.forms.length)
    this.forms[this.randomTabIndex].classList.remove("d-none")
    this.forms[this.randomTabIndex].classList.add("show")
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
    // identify with htmlFor
    console.log(event.target.htmlFor)
    let emojis = this.emojiTargets
    console.log(emojis)
    emojis.forEach((element, index) => {
      if (element.htmlFor = event.target.htmlFor) {
          emojis.splice((index + 1), index)
      }
      // else {
      //   element.attributes[1] = filter: saturate(50%);
      // }
    })
  }
}
