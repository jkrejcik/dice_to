import { Controller } from "@hotwired/stimulus"
import Pluralize from 'pluralize'

// Connects to data-controller="time-saved"
export default class extends Controller {
  static targets = ["roll", "accept", "panel"]

  connect() {
    this.startTime = new Date()
    if (this.panelTarget.attributes.class.value.includes("movie")) { this.averageDecision = 450 }
    if (this.panelTarget.attributes.class.value.includes("restaurant")) { this.averageDecision = 840 }
    
    let time = document.getElementsByClassName("time")[1]
    if (time) {
      let timeTaken = parseFloat(time.innerText)
      if (timeTaken > 60) {
        let minutes = Math.floor(timeTaken / 60) % 60;
        timeTaken -= minutes * 60
        let seconds = (timeTaken % 60).toFixed(0)
        time.innerText = Pluralize('min', minutes, true) + `, ${seconds} seconds`
      }
      else {
        time.innerText = timeTaken.toFixed(2) + " seconds"
      }
    }
  }

  time(event){
    let decisionTime = new Date()
    let timeTaken = Math.abs(this.startTime - decisionTime) / 1000
    document.getElementById("time_taken").value = timeTaken
    console.log(timeTaken)
  }

  final(event){
    // getting time from question page
    let timeSoFar = parseFloat(document.getElementsByClassName("time")[0].value)
    let approvalTime = new Date()
    // elapsed time on page before decision
    let extraDecisionTime = Math.abs(this.startTime - approvalTime) / 1000
    let timeTaken = this.averageDecision - (timeSoFar + extraDecisionTime)
    document.getElementById("time_taken").value = timeTaken
  }
}

