import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core";

// Connects to data-controller="show-check-box"
export default class extends Controller {

  static targets = ["select", "generate", "checkbox", "submit", "tick"]

  connect() {
    console.log("Connected to show-checkbox-controller")
  }

  show() {
    this.generateTarget.classList.remove("cal-hide");
    this.checkboxTargets.forEach(check => {
      check.classList.remove("cal-hide");
    });
    this.selectTarget.classList.add("cal-hide");
  }

  enableGenerate() {
    let foundChecked = false
    this.tickTargets.forEach(tick => {
      if (tick.checked) {
        foundChecked = true
      };

      if (foundChecked == true) {
        this.submitTarget.classList.remove("btn-disable");
      } else {
        this.submitTarget.classList.add("btn-disable");
      };
    });
  }
}
