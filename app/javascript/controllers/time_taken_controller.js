import { Controller } from "@hotwired/stimulus"
import Pluralize from 'pluralize'

// Connects to data-controller="time-taken"
export default class extends Controller {
  static targets = "roll"

  connect() {
    this.startTime = new Date()
    console.log("hello")
  }
  // const timeTaken = (event) => {}

  time(event){
    let decisionTime = new Date()
    let timeTaken = Math.abs(this.startTime - decisionTime) / 1000
    document.getElementById("time_taken").value = timeTaken.toString
    console.log(document.getElementById("time_taken").value)
  }
}

// time(event){
//   let decisionTime = new Date()
//   let timeTaken = Math.abs(this.startTime - decisionTime) / 1000
//   if (timeTaken > 60) {
//     let minutes = Math.floor(timeTaken / 60) % 60;
//     timeTaken -= minutes * 60
//     let seconds = (timeTaken % 60).toFixed(0)
//     document.getElementById("time_taken").value = Pluralize('minute', minutes, true) + `, ${seconds} seconds`
//   }
//   else {
//     document.getElementById("time_taken").value = timeTaken.toFixed(2) + " seconds"
//   }
// }