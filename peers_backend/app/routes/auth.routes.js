
const multer = require('multer');

const {
    verifySignUp
} = require("../middleware");
const controller = require("../controllers/auth.controller");

module.exports = function (app) {
    app.use((req, res, next) => {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );
        express.static(__dirname+'/pfp');
        next();
    });
    var storage = multer.diskStorage({
        destination: function (req, file, cb) {
          cb(null, 'uploads')
        },
        filename: function (req, file, cb) {
          cb(null, new Date().toISOString()+file.originalname)
        }
      })
    var upload = multer({ storage: storage })
    app.post(
        "/signup",
        [
            verifySignUp.checkDuplicateEmail,
            verifySignUp.checkRolesExisted, 
            upload.single('profilepicture')
        ],
        controller.signup
    )

    app.post("/signin", controller.signin );

};