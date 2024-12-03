import { Controller } from "@hotwired/stimulus";

// this popup always appear when you load the page, if we want to do same popup but calling
// it in an action like click we have to do a new controller and set the data action
// action#openPopup where we want
export default class extends Controller {
  static targets = ["rootPopup", "popupContent"];

  connect() {
    console.log("Popup controller connected");
    this.initClickOutsideEventListener();
    this.openPopup()
  }

  openPopup() {
    console.log("Opening popup");
    this.rootPopupTarget.classList.add("active");

    setTimeout(() => {
      this.closePopup();
    }, 3000); // 3 seconds
  }

  closePopup() {
    console.log("Closing popup");
    this.rootPopupTarget.classList.remove("active");
  }

  initClickOutsideEventListener() {
    this.rootPopupTarget.addEventListener("click", (event) => {
      if (!this.popupContentTarget.contains(event.target)) {
        this.closePopup();
      }
    });
  }
}
