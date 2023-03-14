import { Controller } from "@hotwired/stimulus"
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

  toggle(event) {
    if (event.target.classList.contains("minus-button")) {
      event.target.parentElement.parentElement.remove(this.lineTarget.innerHTML) 
    }
    else {
      let currentLine = document.getElementById(this.counter)
      this.counter += 1
      let newLine = currentLine.cloneNode(true)
      newLine.id = this.counter
      let newTextField = newLine.firstChild.nextElementSibling 
      newTextField.value = ""
      newTextField.name = `custom_result[options_attributes][${this.counter}][input]`
      if (this.formTarget.children.length > 1) {
        currentLine.insertAdjacentElement("afterend", newLine) 
      } else {
          this.formTarget.insertAdjacentElement("beforeend", newLine)
      }
    event.target.classList.replace("plus-button", "minus-button")
    }
  }
}
