import 'package:flutter/foundation.dart';

class Event {
  final String? id;
  final String name;
  final String location;
  final String description;
  final List<Tags> tags;

  Event({this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.tags});

  factory Event.fromJson(Map<dynamic, dynamic> json) {
    return Event(
        id: json['id'],
        name: json['name'],
        location: json['location'],
        description: json['description'],
        tags: json['tags']);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'description': description,
    'tags': tags
  };

  Map<String, dynamic> toDB() => {
    'name': name,
    'location': location,
    'description': description,
    'tags': tags
  };

  @override
  String toString() {
    // TODO: implement toString
    return 'name: $name, location $location, description $description, tags $tags';
  }
}

enum Tags {
  music,
  drinks,
  museum,
  festival,
  concert,
  party,
  coffee,
  walk,
  city_walk,
  forest_walk
}
