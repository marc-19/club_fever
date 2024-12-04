import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["rootConfirmation", "confirmationContent"];

  connect() {
    console.log("Confirmation controller connected");
  }

  openConfirmation(event) {
    event.preventDefault();
    console.log("Opening confirmation popup");
    this.rootConfirmationTarget.style.display = "block";
    this.form = event.target.closest('form');
  }

  closeConfirmation() {
    console.log("Closing confirmation popup");
    this.rootConfirmationTarget.style.display = "none";
    this.form = null;
  }
}
