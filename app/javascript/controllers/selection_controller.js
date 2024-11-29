import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="selection"
export default class extends Controller {
  static targets = ["selectedElement"];

  connect() {
    console.log("Stimulus controller connected");
    this.setInitialSelectedClass();
  }

  setInitialSelectedClass() {
    // Iterate through all radio buttons in the group
    this.selectedElementTargets.forEach((group) => {
      const checkedRadio = group.querySelector("input[type='radio']:checked");

      if (checkedRadio) {
        const correspondingLabel = group.querySelector(`label[for="${checkedRadio.id}"]`);
        if (correspondingLabel) {
          correspondingLabel.classList.add("selected");
        }
      }
    });
  }

  select(event) {
    const selectedTarget = event.target;
    const group = selectedTarget.closest(".options");

    // Remove 'selected' class from all labels in the group
    group.querySelectorAll(".result-button").forEach((label) => {
      label.classList.remove("selected");
    });

    // Add 'selected' class to the clicked label
    const selectedLabel = group.querySelector(`label[for="${selectedTarget.id}"]`);
    selectedLabel.classList.add("selected");
  }
}
