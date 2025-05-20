
// server.js
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const twilio = require('twilio');

const app = express();
app.use(bodyParser.json());
app.use(cors()); // allows frontend on other ports to access

// Replace with your real Twilio credentials
const accountSid = 'YOUR_TWILIO_ACCOUNT_SID';
const authToken = 'YOUR_TWILIO_AUTH_TOKEN';
const twilioPhoneNumber = 'YOUR_TWILIO_PHONE_NUMBER'; // E.g., '+1415XXXXXXX'
const client = new twilio(accountSid, authToken);

// Route to send OTP (verification code)
app.post('/send-verification', (req, res) => {
  const { to, code } = req.body;

  client.messages
    .create({
      body: `Your Thailand CBDC Wallet verification code is: ${code}`,
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
    .then(message => res.json({ status: 'sent', sid: message.sid }))
    .catch(error => res.status(500).json({ status: 'error', message: error.message }));
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`CBDC Wallet Backend running on port ${PORT}`);
});

