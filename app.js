
let transactionHistory = [];

// Call backend to send verification SMS
function completeLogin() {
  fetch('/send-verification', {
    method: 'POST'
  })
  .then(res => res.json())
  .then(data => {
    alert(data.message || "Login Completed");
  })
  .catch(err => {
    console.error("Verification error:", err);
    alert("Login failed. Please try again.");
  });
}

// Transfer function with backend alert + local history
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

  // Send SMS alert using backend
  fetch('/send-transaction', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      receiverName,
      receiverNumber,
      receiverBank,
      amount,
      type
    })
  })
  .then(res => res.json())
  .then(data => {
    alert(data.message || `Transfer of THB ${amount.toFixed(2)} to ${receiverName} (${receiverBank}) initiated.`);

    // Add to local history
    transactionHistory.push({
      name: receiverName,
      number: receiverNumber,
      bank: receiverBank,
      amount,
      type,
      date: timestamp
    });

    renderTransactions();
  })
  .catch(err => {
    console.error("Transaction error:", err);
    alert("Transaction failed.");
  });
}
