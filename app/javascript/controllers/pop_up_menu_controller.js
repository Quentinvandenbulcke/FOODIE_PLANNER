import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pop-up-menu"
export default class extends Controller {
  static targets = [ "hideable" ]

  connect() {
    console.log("hello from popup controller");
  }

  showTargets(event) {
    this.hideableTargets.forEach(el => {
      el.hidden = false;
    });
    this.element.parentElement.classList.add("body-freeze")
    // console.log(event.currentTarget.parentElement.dataset.date)
  }

  hideTargets() {
    this.hideableTargets.forEach(el => {
      el.hidden = true
    });
    this.element.parentElement.classList.remove("body-freeze");
  }

  toggleTargets() {
    this.hideableTargets.forEach((el) => {
      el.hidden = !el.hidden;
    });
  }
}
