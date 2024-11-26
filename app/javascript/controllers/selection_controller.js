import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="selection"
export default class extends Controller {
  static targets = ["selectedElement"];

  connect() {
    console.log("Stimulus controller connected");
  }

  select(event) {

    const selectedTarget = event.target;
    const group = selectedTarget.closest(".options"); // its to select the actual option that corresponds (see new.html predictions)

    // clean selected class for all the groups 1 X 2 (so just one appears selected)
    group.querySelectorAll(".result-button").forEach((label) => {
      label.classList.remove("selected");
    });

    // add selected class to the correct selected label
    const selectedLabel = group.querySelector(`label[for="${selectedTarget.id}"]`);
    selectedLabel.classList.add("selected");
  }
}
