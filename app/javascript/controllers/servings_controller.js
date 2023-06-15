import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="servings"
export default class extends Controller {

  add(event) {
    event.preventDefault();
    const mealId = event.currentTarget.dataset.mealId
    const input = document.querySelector(`span[data-servings-target="input${mealId}"]`)
    const value = parseInt(input.innerText) + 1
    const url = event.target.getAttribute("data-meal-url")

    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken = null; // Déclaration de la variable csrfToken

    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.content; // Assignation de la valeur à la variable csrfToken
    }

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ mealId, value }),
    })
    .then(response => response.json())
    .then(data => {
      console.log(data)
        const newQuantity = data.quantity;
        input.textContent = newQuantity;
      })
  }

  minus(event) {
    event.preventDefault();
    const mealId = event.currentTarget.dataset.mealId
    const input = document.querySelector(`span[data-servings-target="input${mealId}"]`)
    const value = parseInt(input.innerText) -1
    const url = event.target.getAttribute("data-meal-url")

    const csrfTokenMeta = document.querySelector('meta[name="csrf-token"]');
    let csrfToken = null; // Déclaration de la variable csrfToken

    if (csrfTokenMeta) {
      csrfToken = csrfTokenMeta.content; // Assignation de la valeur à la variable csrfToken
    }

    fetch(url, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        Accept: "application/json",
        "X-CSRF-Token": csrfToken
      },
      body: JSON.stringify({ mealId, value }),
    })
    .then(response => response.json())
    .then(data => {
      console.log(data)
        const newQuantity = data.quantity;
        input.textContent = newQuantity;
      })
  }
}
