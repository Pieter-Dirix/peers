const db = require("../models");
const ROLES = db.ROLES;
const User = db.user;

checkDuplicateEmail = (req, res, next) => {
    User.findOne({
        email: req.body.email
    }).exec((err, user) => {
        if (err) {
            res.status(500).send({
                message: err
            })
            return;
        }

        if (user) {
            res.status(400).send({
                message: 'This email is already in use'
            })
            return;
        }
        next();
    })
};

checkRolesExisted = (req, res, next) => {
    if (req.body.roles) {
        req.body.roles.forEach(role => {
            if (!ROLES.includes(role)) {
                res.status(400).send({
                    message: `Failed! Role ${req.body.roles[i]} does not exist!`
                });
                return;
            }
        });
    }
    next();
};