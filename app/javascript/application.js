// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "bootstrap"
import { initDatepickr, initTimepickr  } from "./plugins/flatpickr";

initDatepickr();
initTimepickr();
