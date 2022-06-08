import { Controller } from "@hotwired/stimulus";
import Quagga from "@ericblade/quagga2";
import { Modal } from "bootstrap";

export default class extends Controller {
  static targets = ["scanVideo", "foundIsbn"];

  connect() {
    this.csrfToken = document
      .querySelector('meta[name="csrf-token"]')
      .getAttribute("content");
    console.log("Scanner controller connected");
  }

  init() {
    const isbnElement = this.foundIsbnTarget;
    const confirmationModal = new Modal("#confirmationModal");
    Quagga.init(
      {
        inputStream: {
          name: "Live",
          type: "LiveStream",
          target: this.scanVideoTarget,
        },
        decoder: {
          readers: ["ean_reader"],
        },
        locator: {
          halfSample: true,
          patchSize: "x-large",
        },
      },
      function (err) {
        if (err) {
          console.log(err);
          return;
        }
        console.log("Initialization finished. Ready to start");
        Quagga.start();
        Quagga.onDetected((data) => {
          console.log(data.codeResult);
          let code = data.codeResult.code;
          if (code.startsWith("978")) {
            Quagga.stop();
            document.querySelector("#book_isbn").value = code;
            // confirm(code);
          } else {
            document.querySelector("#book_isbn").value = "No ISBN";
          }
        });
      }
    );
  }

  stop() {
    Quagga.stop();
    this.scanVideoTarget.innerHTML = "";
  }
}
