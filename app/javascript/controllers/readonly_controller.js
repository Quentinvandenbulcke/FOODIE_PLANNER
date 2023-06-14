import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="readonly"
export default class extends Controller {
  static targets = ["input", "button"]

  toggleEditable(event) {
    const input = this.inputTarget

    console.log(event.currentTarget)

    if (input.readOnly) {
      input.readOnly = false
      input.classList.remove("readonly")
      event.currentTarget.innerHTML = `<i class="fa-solid fa-check"></i>`
    } else {
      input.readOnly = true
      input.classList.add("readonly")
      event.currentTarget.innerHTML = `<i class="fa-solid fa-pencil"></i>`
    }
  }
}
