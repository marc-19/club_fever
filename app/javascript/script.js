// Carrossel functionality remains the same
const carousel = document.getElementById("carousel");
const prevBtn = document.getElementById("prev-btn");
const nextBtn = document.getElementById("next-btn");

// Function for "previous" button
prevBtn.addEventListener("click", () => {
  carousel.scrollBy({
    left: -200, // Scroll to the left
    behavior: "smooth",
  });
});

// Function for "next" button
nextBtn.addEventListener("click", () => {
  carousel.scrollBy({
    left: 200, // Scroll to the right
    behavior: "smooth",
  });
});

// Enable swipe navigation for the carousel
let startX;

carousel.addEventListener("touchstart", (e) => {
  startX = e.touches[0].clientX;
});

carousel.addEventListener("touchmove", (e) => {
  const deltaX = startX - e.touches[0].clientX;
  carousel.scrollBy({
    left: deltaX,
  });
  startX = e.touches[0].clientX;
});
