import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="readonly"
export default class extends Controller {
  static targets = ["input", "button"]

  toggleEditable(event) {
    const input = this.inputTarget

    if (input.readOnly) {
      input.readOnly = false
      input.classList.remove("readonly")
      this.buttonTarget.innerHTML = "Save"
    } else {
      input.readOnly = true
      input.classList.add("readonly")
      this.buttonTarget.innerHTML = "Edit"
    }
  }
}
