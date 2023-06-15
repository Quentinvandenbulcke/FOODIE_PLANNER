import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="counter"
export default class extends Controller {
  connect() {
    console.log("helo from counter controller")
  }
}
