// server.js
// Backend server for SADC Tokenized Bond Platform
// Handles bond issuance, notifications, and integration with Twilio for SMS alerts

const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const twilio = require('twilio');

// Load environment variables
require('dotenvWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const twilioPhoneNumber = process.env.TWILIO_PHONE_NUMBER;
const client = new twilio(accountSid, authToken);

// Sample bond details for SADC countries
const bondDetails = {
  south_africa: {
    issuer: 'South Africa National Treasury',
    maturityDate: '2028-12-31',
   4.5, // 4.5%
    bidValue: 950,
    askValue: 970
  },
  zimbabwe: {
    issuer: 'Zimbabwe National Treasury',
    maturityDate: '2029-03-15',
    interestRate: 6, // 6%
    bidValue: 1100,
    askValue: 1150
  },
  namibia: {
    issuer: 'Namibia National Treasury',
    maturityDate: '2026-03-31',
    interestRate: 4.8, // 4.8%
    bidValue: 880,
    ask: 5.5, // 5.5%
    bidValue: 1050,
    askValue: 1075
  }
};

// Route to fetch bond details for a specific issuer
app.get('/bond-details/:country', (req, res) => {
  const country = req.params.country.toLowerCase();
  const details = bondDetails[country];
  if (!details) {
    return res.status(404).json({ status: 'error', message: 'Issuer not found' });
  }
  res.json({ status: 'success', details });
});

// Route to send OTP (verification code)
app.post('/sendcode}`,
      from: twilioPhoneNumber,
      to: to
    })
    .then(message => res.json({ status: 'sent', sid: message.sid }))
    .catch(error => res.status(500).json({ status: 'error', message: error.message }));
});

// Route to send transaction notification
app.post('/send-transaction-alert', (req, res) => {
  const { to, message } = req.body;

  client.messages
    .create({
      body: message,
      from: twilioPhoneNumber,
      to: to
    })
    .then(message => res.json({ status: 'sent notify bond issuance
app.post('/notify-bond-issuance', (req, res) => {
  const { to, country, amount } = req.body;
  const details = bondDetails[country.toLowerCase()];
  if (!details) {
    return res.status(404).json({ status: 'error', message: 'Issuer not found' });
  }

  const message = `Bond issued by ${details.issuer} for ${amount} units. 
  Interest Rate: ${details.interestRate}%, Maturity Date: ${details.maturityDate}`;
  
  client.messages
    .create({
      body: message(error => res.status(500).json({ status: 'error', message: error.message }));
});

// Route to issue a bond (mock implementation)
app.post('/issue-bond', (req, res) => {
  const { country, recipient, amount, yieldRate, interestRate, maturityDate, bid, ask } = req.body;
  const details = bondDetails      yieldRate,
      interestRate,
      maturityDate,
      bid,
      ask
    }
  });
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`SADC CBDC Wallet Backend running on port ${PORT}`);
});