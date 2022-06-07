import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-area"
export default class extends Controller {
  connect() {
    console.log("Here I am!")
  }

  refresh(event) {
    console.log("Here I am as well!")
  }
}
