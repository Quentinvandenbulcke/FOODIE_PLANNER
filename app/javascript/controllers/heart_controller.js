import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="heart"
export default class extends Controller {
static targets = ["iconfill", "iconempty"]

  connect() {
    console.log("hellooo from heart controller");
  }

  favorite(event) {
    // event.preventDefault()
    // console.log("Lets favorite this");
    // console.log("print iconemptytarger")
    // console.log(this.iconemptyTarger);
    // console.log("print iconemptytarget parent")
    // console.log(this.iconemptyTarget.parentElement);
    this.iconemptyTarget.parentElement.classList.add("hide-icon")
    this.iconfillTarget.parentElement.classList.remove("hide-icon")
    // fetch(this.iconTarget.parentElement.href, {
    //   method: "POST",
    //   headers: { "Accept": "application/json" },
    //   body: this.iconTarget.parentElement
    // })
    //   .then(response => response.json())
    //   .then((data) => {
    //     console.log(data)
    //   })
  }

  unfavorite() {
    // event.preventDefault()
    // console.log("Lets unfavorite this");
    this.iconemptyTarget.parentElement.classList.remove("hide-icon")
    this.iconfillTarget.parentElement.classList.add("hide-icon")
  }
}
