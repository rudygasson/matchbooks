import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  connect() {
    console.log("Working!")
    flatpickr(".datepicker", { altInput: true});
    flatpickr(".timepicker", { enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      time_24hr: true});
  }
}
