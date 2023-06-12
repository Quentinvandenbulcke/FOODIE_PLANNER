import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-check-box"
export default class extends Controller {

  static targets = ["select", "generate", "checkbox"]

  connect() {
    console.log("Connected to show-checkbox-controller")
  }

  show() {
    // console.log(this.selectTarget)
    // console.log(this.generateTarget)
    console.log(this.checkboxTarget);
    console.log(this.checkboxTargets);
    this.generateTarget.classList.remove("cal-hide");
    this.checkboxTargets.forEach(check => {
      console.log(check)
      check.classList.remove("cal-hide");
    });
    this.selectTarget.classList.add("cal-hide");
  }
}
