
let transactionHistory = [];

function completeLogin() {
  alert("Login Completed");
}

function transfer() {
  const receiverName = document.getElementById("receiverName").value;
  const receiverNumber = document.getElementById("receiverNumber").value;
  const receiverBank = document.getElementById("receiverBank").value;
  const amount = parseFloat(document.getElementById("amount").value);
  const type = document.getElementById("type").value;
  const timestamp = new Date().toISOString();

  if (!receiverName || !receiverNumber || !receiverBank || !amount || amount <= 0) {
    alert("Please fill all fields correctly.");
    return;
  }

  // Simulate transfer
  transactionHistory.push({
    name: receiverName,
    number: receiverNumber,
    bank: receiverBank,
    amount,
    type,
    date: timestamp
  });

  alert(`Transfer of THB ${amount.toFixed(2)} to ${receiverName} (${receiverBank}) initiated.`);

  renderTransactions(); // Update history
}

function renderTransactions() {
  const start = new Date(document.getElementById("startDate").value);
  const end = new Date(document.getElementById("endDate").value);
  const filterType = document.getElementById("filterType").value;

  const transactionsDiv = document.getElementById("transactions");
  transactionsDiv.innerHTML = "";

  let filtered = transactionHistory.filter(tx => {
    const txDate = new Date(tx.date);
    const inDateRange = (!isNaN(start) ? txDate >= start : true) && (!isNaN(end) ? txDate <= end : true);
    const typeMatch = filterType === "" || tx.type === filterType;
    return inDateRange && typeMatch;
  });

  if (filtered.length === 0) {
    transactionsDiv.innerHTML = "<p>No transaction history available.</p>";
    return;
  }

  filtered.forEach(tx => {
    const txItem = document.createElement("div");
    txItem.innerHTML = `<strong>${tx.type}</strong>: THB ${tx.amount.toFixed(2)} to ${tx.name} (${tx.bank}) on ${new Date(tx.date).toLocaleString()}`;
    transactionsDiv.appendChild(txItem);
  });
}
