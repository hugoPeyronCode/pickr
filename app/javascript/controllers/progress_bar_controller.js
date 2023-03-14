import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress-bar"
export default class extends Controller {
  static values= {deckId: Number}
  connect() {
    this.updateProgressBar();
    this.startProgressBar = setInterval(() => { this.updateProgressBar() }, 500);
  }

  disconnect() {
    clearInterval(this.startProgressBar)
  }

  updateProgressBar() {
    console.log("progress here")
    var progressBar = document.querySelector('.progress-bar');
    var deckId = this.deckIdValue;

    // Send an AJAX request to get the updated progress status
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/decks/' + deckId + '/progress', true);
    xhr.onload = function() {
        if (xhr.status === 200) {
          var response = JSON.parse(xhr.responseText);
          var completedPercent = response.completed_percent;

          // Update the progress bar
          progressBar.style.width = completedPercent + '%';
          progressBar.setAttribute('aria-valuenow', completedPercent);
          progressBar.innerHTML = completedPercent + '%';
      }
    };
    xhr.send();
  }
}
