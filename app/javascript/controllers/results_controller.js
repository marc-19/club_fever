import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["option", "button"];

  connect() {
    //console.log("Stimulus Controller Connected");
    this.setInitialSelection();
  }

  setInitialSelection() {
    this.optionTargets.forEach((option) => {
      const result = option.dataset.result; // get the result from the data attribute
      //console.log(`Expected Result: ${result}`);

      const selectedButton = option.querySelector(`.result-button.btn-${this.getButtonClass(result)}`);
      if (selectedButton) {
        selectedButton.classList.add("selected");
      }
    });
  }

  getButtonClass(result) {
    // Map the result to its respective class
    switch (result) {
      case "1":
        return "local";
      case "X":
        return "draw";
      case "2":
        return "visitor";
      default:
        return "";
    }
  }
}
