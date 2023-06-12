import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="heart"
export default class extends Controller {
static targets = ["icon", "card"]

  connect() {
    console.log("hellooo");
  }

  favorite(event) {
    event.preventDefault()
    console.log("Lets do this");
    // console.log(this.iconTarget);


    fetch(this.iconTarget.parentElement.href, {
      method: "POST",
      headers: { "Accept": "application/json" },
      body: this.iconTarget.parentElement
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data)
      })
  }

  unfavorite() {}
}
