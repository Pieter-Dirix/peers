const express = require('express');
const mongoose = require('mongoose');
const uri = `mongodb+srv://admin:admin@peers.wsqfc.mongodb.net/myFirstDatabase?retryWrites=true&w=majority`;

const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

// https://medium.com/@sergio13prez/connecting-to-mongodb-atlas-d1381f184369
mongoose.connect(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => {
  console.log(`MongoDB Connected…`)
})
.catch(err => console.log(err));