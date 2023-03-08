import { Controller } from "@hotwired/stimulus"
import { Swiper } from '../class/swiper'

// Connects to data-controller="swipe"
export default class extends Controller {
  static targets = ["card"]
  connect() {
    this.initSwiper()
  }

  initSwiper() {
    new Swiper({
      cards: this.cardTargets,
      likedCallback: this.swipeRight.bind(this),
      dislikedCallback: this.swipeLeft.bind(this)
    })
  }

  swipeLeft(id){
    const url = `/matches`
    const options = {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        "id": id,
        "liked": false
      })
    }
    fetchWithToken(url, options)
  }


  swipeRight(id){
    const url = "/matches"
    const options = {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        "id": id,
        "liked": true
      })
    }
    fetchWithToken(url, options)
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }
}
