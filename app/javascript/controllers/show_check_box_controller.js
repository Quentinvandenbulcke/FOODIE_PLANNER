import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-check-box"
export default class extends Controller {

  static targets = ["select", "generate", "checkbox"]
  connect() {
    console.log("i m connected to show checkbox controller")
  }

  show() {
    console.log(this.selectTarget)
    console.log(this.generateTarget)
    console.log(this.checkboxTarget)
    this.generateTarget.classList.remove("cal-hide")
    this.checkboxTarget.classList.remove("cal-hide")
    this.selectTarget.classList.add("cal-hide")
  }
}
