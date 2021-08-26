const express = require('express');
const {
    verifySignUp, authJwt
} = require("../middleware");
const controller = require("../controllers/event.controller");

module.exports = function (app) {
    app.use((req, res, next) => {
        res.header(
            "Access-Control-Allow-Headers",
            "x-access-token, Origin, Content-Type, Accept"
        );

        next();
    });

    app.post(
        "/addevent",
        [
            authJwt.verifyToken,
        ],
        controller.addevent
    )

    app.get(
        "/getevents/:userId", 
        [
            authJwt.verifyToken,
        ], 
        controller.getevents
    );

};