import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range-slider"
export default class extends Controller {

  static targets = ["euro"]

  connect() {
    console.log("hey")
    console.log(this.euroTarget)
  }

  change(event) {

    var price = parseInt(event.currentTarget.value);
    var euros = '€'.repeat(price);
    this.euroTarget.innerText = euros;
  }
}
