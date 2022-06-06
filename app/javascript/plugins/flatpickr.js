import flatpickr from "flatpickr";

const initDatepickr = () => {
  flatpickr(".datepicker", { altInput: true});
}

const initTimepickr = () => {
  flatpickr(".timepicker", { enableTime: true,
    noCalendar: true,
    dateFormat: "H:i",
    time_24hr: true});
}

export { initDatepickr, initTimepickr };
