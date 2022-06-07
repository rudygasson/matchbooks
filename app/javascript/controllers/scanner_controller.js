import { Controller } from "@hotwired/stimulus";
import {
  BrowserBarcodeReader,
  BrowserCodeReader,
  BarcodeFormat,
} from "@zxing/library";
import { DecodeHintType } from "@zxing/library";

export default class extends Controller {

  connect() {
    console.log("Scanner controller connected");

    let selectedDeviceId;
    const hints = new Map();
    const formats = [BarcodeFormat.EAN_13];
    hints.set(DecodeHintType.POSSIBLE_FORMATS, formats);
    const codeReader = new BrowserBarcodeReader();
    console.log("ZXing code reader initialized");

    codeReader.getVideoInputDevices()
      .then((videoInputDevices) => {
        selectedDeviceId = videoInputDevices[0].deviceId;

        document.getElementById("startButton").addEventListener("click", () => {
          codeReader
            .decodeOnceFromVideoDevice(selectedDeviceId, "video")
            .then((result) => {
              console.log(result);
              document.getElementById("result").textContent = result.text;
            })
            .catch((err) => {
              console.error(err);
              document.getElementById("result").textContent = err;
            });
          console.log(
            `Started continous decode from camera with id ${selectedDeviceId}`
          );
        });

        document.getElementById("resetButton").addEventListener("click", () => {
          codeReader.reset();
          console.log("Reset.");
        });
      })
      .catch((err) => {
        console.error(err);
      });
  }
}
