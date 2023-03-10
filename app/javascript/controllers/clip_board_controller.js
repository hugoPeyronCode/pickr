import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clip-board"
export default class extends Controller {
  static targets = ["input"];
  static values = {
    feedbackText: String
  }

  connect() {
  }

  copy(event) {
    console.log("click")
    this.inputTarget.select();
    document.execCommand('copy');
    event.currentTarget.disabled = true;
    event.currentTarget.innerText = this.feedbackTextValue;
  }
}
