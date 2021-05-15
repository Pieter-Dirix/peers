require('dotenv').config()
const express = require('express');
const cors = require('cors');
const mongoose = require('mongoose');
const uri = process.env.DB_ADMIN_LINK;

const app = express()
const port = process.env.PORT;

const db = require('./app/models')
const Role = db.role;

let corsOptions = {
  origin: "http://localhost:3000"
}

app.use(cors(corsOptions));

app.use(express.json());

app.use(express.urlencoded({ extended: true }));



app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})

// https://medium.com/@sergio13prez/connecting-to-mongodb-atlas-d1381f184369
db.mongoose.connect(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
.then(() => {
  console.log(`MongoDB Connected…`)
})
.catch(err => console.log(err));

function initial() {
  Role.estimatedDocumentCount( (err, count) => {

    if(!err && count === 0) {

      new Role({
        name: "user"
      }).save( err => {
        if(err) {
          console.log('error', err);
        }

        console.log('added "user" to the roles collection');
      });

      new Role({
        name: 'admin'
      }).save( err => {
        if(err) {
          console.log('error', err);
        }

        console.log('added "admin" to the roles collection');
      });
    }
  })
}