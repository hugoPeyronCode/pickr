import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range-slider"
export default class extends Controller {

  static targets = ["euro"]

  connect() {
  }

  change(event) {

    var price = parseInt(event.currentTarget.value);
    var euros = '€'.repeat(price + 1);
    this.euroTarget.innerText = euros;
  }
}
