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
        profilepicture: {
            type: String
        },
        roles: [
            {
                type: mongoose.Schema.Types.ObjectId,
                ref: "Role"
            }
        ]
    })
);

module.exports = User;