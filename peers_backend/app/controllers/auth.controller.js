const config = require("../config/auth.config");
const db = require("../models");
const User = db.user;
const Role = db.role;

let jwt = require("jsonwebtoken");
let bcrypt = require("bcryptjs");

module.exports.signup = (req, res) => {
    const user = new User({
        firstname: req.body.firstname,
        lastname: req.body.lastname,
        email: req.body.email,
        password: bcrypt.hashSync(req.body.password, 8)
    });

    user.save( (err, user) => {
        if(err) {
            res.status(500).send( { message: err } );
            return;
        };

        if(req.body.roles) {
            Role.find( { name: { $in: req.body.roles } }, (err, roles) => {
                if(err) {
                    res.status(500).send( { message: err } );
                    return;
                }

                user.roles = roles.map(role => role._id);
                user.save(err => {
                    if(err) {
                        res.status(500).send({ message: err });
                        return;
                    }

                    res.send({ message: "User was registered successfully" })
                });
            });
        } else {
            Role.findOne({ name: "user"}, (err, role) => {
                if(err) {
                    res.status(500).send({ message: err });
                    return;
                }

                user.roles = [role._id];
                user.save(err => {
                    if(err) {
                        res.status(500).send({ message: err });
                        return;
                    }

                    res.send({ message: "user was registered successfully" });
                });
            });
        }
    });
}

module.exports.signin = (req, res) => {
    User.findOne({ email: req.body.email })
    .populate("roles","-__v")
    .exec((err, user) => {
        if(err) {
            res.status(500).send({ message: err });
            return;
        }

        if(!user) {
            return res.status(404).send({ message: "User not found" });
        }

        let passwordIsValid = bcrypt.compareSync(
            req.body.password,
            user.password
        );

        if(!passwordIsValid) {
            return res.status(401).send({
                accessToken: null,
                message: "Invalid password"
            });
        }

        let token = jwt.sign({ id: user.id}, config.secret, {
            expiresIn: 259200
        });

        let authorities = [];

        user.roles.forEach(role => {
            authorities.push(`ROLE_${role.name.toUpperCase()}`);
        });

        res.status(200).send({
            id: user._id,
            firstname: user.firstname,
            lastname: user.lastname,
            email: user.email,
            roles: authorities,
            accessToken: token
        });
    });
};