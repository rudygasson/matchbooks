import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-area"
export default class extends Controller {
  static targets = ["select", "bookList", "query"]

  connect() {
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
  }

  refresh() {
    const district = this.selectTarget.value
    const query = this.queryTarget.value

    fetch(`/?district=${district}&query=${query}`, {
      method: "GET",
      headers: { "Accept": "application/json", "X-CSRF-Token": this.csrfToken }
    })
      .then(response => response.json())
      .then((data) => {
        this.bookListTarget.innerHTML = data.insert
      })
  }
}
