document.getElementById("search-bar").addEventListener("input", function (event) {
  const value = event.target.value;
  const outputDiv = document.getElementById("output");
  outputDiv.innerText = `You inserted: ${value}`;
});

const carousel = document.getElementById("carousel");
const prevBtn = document.getElementById("prev-btn");
const nextBtn = document.getElementById("next-btn");

// Botão para a esquerda
prevBtn.addEventListener("click", () => {
  carousel.scrollBy({
    left: -200, // Define a distância para "voltar"
    behavior: "smooth",
  });
});

// Botão para a direita
nextBtn.addEventListener("click", () => {
  carousel.scrollBy({
    left: 200, // Define a distância para "avançar"
    behavior: "smooth",
  });
});

// Habilita navegação por toque
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
