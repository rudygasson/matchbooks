import { Controller } from "@hotwired/stimulus";
import Quagga from "@ericblade/quagga2";
import { Modal } from "bootstrap";

export default class extends Controller {
  connect() {
    this.csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content")
    console.log("Scanner controller connected");
    console.log(this.csrfToken);

    this.modal = new Modal(document.getElementById("exampleModal"));
    this.modal.show();
    Quagga.init(
      {
        inputStream: {
          name: "Live",
          type: "LiveStream",
          target: document.querySelector("#scan-video")
        },
        decoder: {
          readers: ["ean_reader"],
        },
        locator: {
          halfSample: true,
          patchSize: "x-large"
        }
      },
      function (err) {
        if (err) {
          console.log(err);
          return;
        }
        console.log("Initialization finished. Ready to start");
        Quagga.onDetected((data) => {
          console.log(data.codeResult);
          let code = data.codeResult.code
          if (code.startsWith('978')) {
            document.querySelector("#result").innerText = code;
            Quagga.stop();
          } else {
            document.querySelector("#result").innerText = 'No ISBN';
          }
        });
      }
    );
    document.querySelector("#startButton").addEventListener("click", (e) => {
      console.log("Start");
      Quagga.start();
    });
  }
}
