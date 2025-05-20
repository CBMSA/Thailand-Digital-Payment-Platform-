function completeLogin() {
  alert("Login Completed");
}

function transfer() {
  const receiverName = document.getElementById("receiverName").value;
  const receiverNumber = document.getElementById("receiverNumber").value;
  const receiverBank = document.getElementById("receiverBank").value;
  const amount = document.getElementById("amount").value;
  const type = document.getElementById("type").value;
  alert(`Transfer of THB ${amount} to ${receiverName} (${receiverBank}) initiated.`);
}

function renderTransactions() {
  const transactionsDiv = document.getElementById("transactions");
  transactionsDiv.innerHTML = "<p>No transaction history available yet.</p>";
}