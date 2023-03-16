import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sharing"
export default class extends Controller {
  static values = {
    title: String,
    url: String,
  }
  share() {
    const sharingObj = {
      title: this.titleValue,
      text: `Hey, which would you pick for us out of those suggestions : ${this.titleValue}`,
      url: this.urlValue
    }
    if (navigator.share) {
      navigator.share(sharingObj)
        .then(() => { console.log('Thanks for sharing!') })
        .catch(console.error);
    } else {
      console.log(sharingObj)
    }
  }
}
