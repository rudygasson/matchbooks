import { Controller } from "@hotwired/stimulus";
import Quagga from "@ericblade/quagga2";

export default class extends Controller {
  static targets = ["scanVideo"];

  connect() {
    console.log("Scanner controller connected");
  }

  init() {
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
        console.log("Initialization finished. Ready to scan");
        Quagga.start();
        Quagga.onDetected((data) => {
          console.log(data.codeResult);
          let code = data.codeResult.code;
          if (code.startsWith("978")) {
            Quagga.stop();
            document.querySelector("#book_isbn").value = code;
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
