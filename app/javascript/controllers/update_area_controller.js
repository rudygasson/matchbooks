import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-area"
export default class extends Controller {
  static targets = ["select", "bookList"]

  connect() {
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
  }

  refresh() {
    const district = this.selectTarget.value
    // console.log(district)
    fetch(`/?district=${district}&query=`, {
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": this.csrfToken }
    })
      .then(response => response.json())
      .then((data) => {
        console.log(data.insert)
        this.bookListTarget.innerHTML = ""
        this.bookListTarget.insertAdjacentHTML('beforeend', data.insert)
      })

  }
}
