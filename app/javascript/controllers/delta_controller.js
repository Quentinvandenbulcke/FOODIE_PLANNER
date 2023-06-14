import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="delta"
export default class extends Controller {
  static targets = ["item", "update"]

  connect() {
    // console.log(this.itemTarget)
    // console.log(this.updateTarget)
  }

  changeValue(event) {
    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken = null; // Déclaration de la variable csrfToken

    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.content; // Assignation de la valeur à la variable csrfToken
    }

    const value = event.target.value;
    const url = event.target.getAttribute("data-update-url")
    // console.log(url)
    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ value }),
    })
    .then(response => response.json())
    .then(data => {
            this.updateTarget.insertAdjacentHTML("beforeend",`<em>${data.updated_at.strftime('%H:%M')}</em>`)
      })
  }

}
