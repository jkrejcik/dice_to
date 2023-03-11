import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = ["form", "line", "sign", "all"]
  
  connect() {
    this.allTarget.onkeypress = function(e) {
      let key = e.charCode || e.keyCode || 0;     
      if (key == 13) {
        e.preventDefault();
      }
    }
    this.counter = 1;
  }

  // submit(event) {
  //   event.preventDefault()
  //   console.log(event.target)
  // }

  toggle(event) {
    event.preventDefault()
    if (event.target.classList.contains("minus-button")) {
      event.target.parentElement.parentElement.remove(this.lineTarget.innerHTML) 
    }
    else {
    let currentLine = document.getElementById(this.counter)
    console.log(event.target.parentElement.parentElement)
    this.counter += 1
    // let lineId = parseInt(this.formTarget.lastChild.id)
    // let lineId = parseInt(this.lineTarget.id)
    let newLine = currentLine.cloneNode(true)
    newLine.id = this.counter
    // newLine.value = ""
    if (this.formTarget.children.length > 1) {
      currentLine.insertAdjacentElement("afterend", newLine) 
    } else {
      this.formTarget.insertAdjacentElement("beforeend", newLine)
    }
    // console.log(newLine)
    // console.log(newLine.value)
    event.target.classList.replace("plus-button", "minus-button")
    // event.target.classList.remove("d-none")
    }
  }

  remove(event) {
    // console.log(event.target.parentElement.parentElement)
    this.lineTarget.remove(this.lineTarget.innerHTML)
    // let blocks = document.getElementsID('1').innerHTML
    // console.log(blocks) 
  }
}
