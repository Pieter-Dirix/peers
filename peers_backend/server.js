//https://bezkoder.com/node-js-mongodb-auth-jwt/
//https://medium.com/@sergio13prez/connecting-to-mongodb-atlas-d1381f184369
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


//https://medium.com/flutter-community/flutter-file-upload-using-multer-node-js-and-mongodb-5ba4da44453e



app.use(cors());

app.use(express.json());

app.use(express.urlencoded({ extended: true }));



app.get('/', (req, res) => {
  res.send('Hello World!')
})

require('./app/routes/auth.routes')(app);
require('./app/routes/user.routes')(app);
require('./app/routes/event.routes')(app);

app.listen(port, () => {
  console.log(`Peers listening at http://localhost:${port}`)
})


db.mongoose.connect(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true
})
  .then(() => {
    console.log(`MongoDB Connected…`);
    initial();
  })
  .catch(err => console.log(err));

function initial() {
  Role.estimatedDocumentCount((err, count) => {

    if (!err && count === 0) {

      new Role({
        name: "user"
      }).save(err => {
        if (err) {
          console.log('error', err);
        }

        console.log('added "user" to the roles collection');
      });

      new Role({
        name: 'admin'
      }).save(err => {
        if (err) {
          console.log('error', err);
        }

        console.log('added "admin" to the roles collection');
      });
    }
  })
}