function pullDown() {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const inputProfit = document.getElementById("profit");
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1)
    inputProfit.innerHTML = Math.round(inputValue - (inputValue * 0.1))
  })

}

window.addEventListener('load', pullDown)