import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["name"]
connect(){
  console.log("coucou")
}

  showname(){
    const name = this.nameTarget.dataset.name
    console.log(name)
    alert(name)
  }
}
