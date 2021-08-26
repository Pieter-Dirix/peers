const mongoose = require('mongoose');

const Event = mongoose.model(
    "Event",
    new mongoose.Schema({
        name: String,
        location: String,
        description: String,
        tags: [
            { type: String, }
        ],
        date: String,
        userId: {
            type: mongoose.Schema.Types.ObjectId,
            ref: "User"
        }
    })
);

module.exports = Event;