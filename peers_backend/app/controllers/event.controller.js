const config = require("../config/auth.config");
const db = require("../models");
const Event = db.event;
const Role = db.role;

let jwt = require("jsonwebtoken");
let bcrypt = require("bcryptjs");

module.exports.addevent = (req, res) => {
    console.log("hier");



    const event = new Event({
        name: req.body.name,
        location: req.body.location,
        description: req.body.description,
        tags: req.body.tags,
        date: req.body.date,
        userId: req.body.userId

    });

    event.save((err, event) => {
        if (err) {
            console.log(err);
            res.status(500).send({
                message: err
            });
            return;
        };

        res.send(event);
    });
}

module.exports.getevents = (req, res) => {
    if (!req.params['userId']) {
        res.status(500).send({
            message: "no ID provided"
        });
        return
    }
    Event.find({
        // userId: {
        //     $ne: req.params['userId']
        // }
    }, function (err, events) {
        if (err) {
            print(err);
            res.status(500).send({
                message: err
            });
            return;
        };

        res.send({
            events: events
        });
    });
}