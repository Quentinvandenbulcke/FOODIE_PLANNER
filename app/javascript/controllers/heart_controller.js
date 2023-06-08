import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="heart"
export default class extends Controller {
static targets = ["icon"]

  connect() {
    console.log("hellooo");
  }

  favorite(event) {
    event.preventDefault();
    console.log("hello 2");
  }
}
