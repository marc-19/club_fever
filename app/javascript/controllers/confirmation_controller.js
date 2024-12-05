import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["rootConfirmation", "confirmationContent"];

  connect() {
    console.log("Confirmation controller connected");
    this.checkIfConfirmed();
  }

  checkIfConfirmed() {
    if (localStorage.getItem('confirmationShown')) {
      // Hide the confirmation popup if it has been shown before
      this.rootConfirmationTarget.style.display = 'none';
    }
  }

  openConfirmation(event) {
    event.preventDefault();
    console.log("Opening confirmation popup");

    // Show confirmation popup only if it hasn't been shown before
    if (!localStorage.getItem('confirmationShown')) {
      this.rootConfirmationTarget.style.display = "block";
      this.form = event.target.closest('form');
    }
  }

  closeConfirmation() {
    console.log("Closing confirmation popup");
    this.rootConfirmationTarget.style.display = "none";
    this.form = null;

    // Set this flag to indicate the confirmation has been shown
    localStorage.setItem('confirmationShown', 'true');
  }
}

// import { Controller } from "@hotwired/stimulus";

// export default class extends Controller {
//   static targets = ["rootConfirmation", "confirmationContent"];

//   connect() {
//     console.log("Confirmation controller connected");
//   }

//   openConfirmation(event) {
//     event.preventDefault();
//     console.log("Opening confirmation popup");
//     this.rootConfirmationTarget.style.display = "block";
//     this.form = event.target.closest('form');
//   }

//   closeConfirmation() {
//     console.log("Closing confirmation popup");
//     this.rootConfirmationTarget.style.display = "none";
//     this.form = null;
//   }
// }
