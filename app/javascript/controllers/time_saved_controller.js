import { Controller } from "@hotwired/stimulus"
import Pluralize from 'pluralize'

// Connects to data-controller="time-saved"
export default class extends Controller {
  static targets = "roll"

  connect() {
    this.startTime = new Date()
  }


  // const timeTaken = (event) => {}

  time(event){
    let decisionTime = new Date()
    let timeTaken = Math.abs(this.startTime - decisionTime) / 1000
    fetch('/movie-questions', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({"time_taken": timeTaken})
    })
      console.log(body)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
    })
  //   if (timeSpent > 60) {
  //     let minutes = Math.floor(timeSpent / 60) % 60;
  //     timeSpent -= minutes * 60
  //     let seconds = (timeSpent % 60).toFixed(0)
  //     // console.log(Pluralize('minute', minutes, true) + `, ${seconds} seconds`)
  //   }
  //   else {
  //     console.log(timeSpent.toFixed(2) + " seconds") 
  //   }
  // }
  }

}
