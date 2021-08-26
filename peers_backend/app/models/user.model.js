const mongoose = require('mongoose');

const User = mongoose.model(
    "User",
    new mongoose.Schema({
        firstname: String,
        lastname: String,
        email: String,
        password: String,
        gender: String,
        school: String,
        bio: String,
        roles: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Role"
            }
        ],
        events:  [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Event"
            }
        ]
    })
);

module.exports = User;