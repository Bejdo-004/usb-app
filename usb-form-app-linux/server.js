const express = require('express');
const bodyParser = require('body-parser');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 3000;

app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.send(`
    <form method="POST" action="/submit">
      <label>Ime:</label><br/>
      <input name="ime" required><br/>
      <label>Broj telefona:</label><br/>
      <input name="telefon" required><br/>
      <button type="submit">Pošalji</button>
    </form>
  `);
});

app.post('/submit', (req, res) => {
  const { ime, telefon } = req.body;
  const data = `Ime: ${ime}, Telefon: ${telefon}\n`;
  fs.appendFileSync(path.join(__dirname, 'usb-podaci.txt'), data);
  res.send('Hvala! USB je sada otključan. Možete zatvoriti ovaj prozor.');
});

app.listen(PORT, () => {
  console.log(`Server radi na http://localhost:${PORT}`);
});
