import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pop-up-menu"
export default class extends Controller {

  // connect() {
  //   console.log("hello")
  // }

  static targets = [ "hideable" ]

  showTargets() {
    this.hideableTargets.forEach(el => {
      el.hidden = false
    });
  }

  hideTargets() {
    this.hideableTargets.forEach(el => {
      el.hidden = true
    });
  }

  toggleTargets() {
    this.hideableTargets.forEach((el) => {
      el.hidden = !el.hidden
    });
  }
}
