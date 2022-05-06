function commission() {
  const priceText = document.getElementById("item-price");
  priceText.addEventListener("keyup", () => {
    const priceVal = priceText.value;
    const priceValNum = Number(priceVal);
    const taxPrice = parseInt(priceValNum*0.1, 10);
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = taxPrice;

    const profit = document.getElementById("profit");
    profit.innerHTML = parseInt(priceValNum*0.9, 10)

  });

};



window.addEventListener("load", commission)