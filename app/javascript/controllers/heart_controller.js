import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="heart"
export default class extends Controller {
static targets = ["iconfill", "iconempty"]

  connect() {
    console.log("hellooo from heart controller");
  }

  favorite(event) {
    event.preventDefault()
    console.log(this.iconemptyTarget.parentElement.href);
    this.iconemptyTarget.parentElement.classList.add("hide-icon")
    this.iconfillTarget.parentElement.classList.remove("hide-icon")
    fetch(this.iconemptyTarget.parentElement.href, {
      method: "POST",
      headers: { "Accept": "application/json", "Content-Type": "application/json" }
    })
  }

  unfavorite(event) {
    event.preventDefault()
    this.iconemptyTarget.parentElement.classList.remove("hide-icon")
    this.iconfillTarget.parentElement.classList.add("hide-icon")

    fetch(this.iconfillTarget.parentElement.href, {
      method: "DELETE",
      headers: { "Accept": "application/json", "Content-Type": "application/json" }
    })
  }
}
