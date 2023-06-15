import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="readonly"
export default class extends Controller {
  // static targets = ["button"]

  toggleEditable(event) {
    const listId = event.currentTarget.dataset.listId
    const input = document.querySelector(`input[data-readonly-target="input${listId}"]`)
    const unit = document.querySelector(`span[data-readonly-target="unit${listId}"]`)

    if (input.readOnly) {
      input.readOnly = false
      input.classList.remove("readonly")
      event.currentTarget.innerHTML = `<i class="fa-solid fa-check"></i>`
    } else {
      input.readOnly = true
      input.classList.add("readonly")
      event.currentTarget.innerHTML = `<i class="fa-solid fa-pencil"></i>`
      if (unit.innerText === "kg") {
        if (input.value < 0.6) {
          unit.innerText = "grams"
          input.value = input.value * 1000
        }
        } else if (unit.innerText === "grams") {
          if (input.value > 600) {
            unit.innerText = "kg"
            input.value = (input.value / 1000).toFixed(1)
          }
        }
    }


    }


  }
