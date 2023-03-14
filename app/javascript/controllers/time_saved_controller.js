import { Controller } from "@hotwired/stimulus"
import Pluralize from 'pluralize'

// Connects to data-controller="time-saved"
export default class extends Controller {
  static targets = ["roll", "accept"]

  connect() {
    this.startTime = new Date()
  }

  time(event){
    let decisionTime = new Date()
    let timeTaken = Math.abs(this.startTime - decisionTime) / 1000
    document.getElementById("time_taken").value = timeTaken
  }

  final(event){
    let averageMovieDecision = 450
    // getting time from question page
    let timeSoFar = parseFloat((document.getElementsByClassName("time"))[0].innerText)
    let approvalTime = new Date()
    // elapsed time on page before decision
    let extraDecisionTime = Math.abs(this.startTime - approvalTime) / 1000
    let timeTaken = averageMovieDecision - (timeSoFar + extraDecisionTime)
    // adding text with answer
    if (timeTaken > 60) {
      let minutes = Math.floor(timeTaken / 60) % 60;
      timeTaken -= minutes * 60
      let seconds = (timeTaken % 60).toFixed(0)
      document.getElementsByClassName("time")[0].innerText = Pluralize('minute', minutes, true) + `, ${seconds} seconds`
    }
    else {
      document.getElementsByClassName("time")[0].innerText = timeTaken.toFixed(2) + " seconds"
    }
    // removing button on accept and showing the time saved
    document.getElementsByClassName("d-none")[0].classList.remove("d-none")
    this.acceptTarget.classList.add("d-none")
  }
}

