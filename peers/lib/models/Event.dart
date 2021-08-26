import 'package:peers/models/Tags.dart';

class Event {
  final String? id;
  final String name;
  final String location;
  final String description;
  final List tags;
  final String date;
  final String userId;

  Event(
      {this.id,
      required this.name,
      required this.location,
      required this.description,
      required this.tags,
      required this.date,
      required this.userId});

  factory Event.fromJson(Map<dynamic, dynamic> json) {
    return Event(
        id: json['id'],
        name: json['name'],
        location: json['location'],
        description: json['description'],
        tags: json['tags'],
        date: json['date'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location,
        'description': description,
        'tags': tags,
        'date': date,
        'userId': userId
      };

  Map<String, dynamic> toDB() => {
        'name': name,
        'location': location,
        'description': description,
        'tags': tags,
        'date': date,
        'userId': userId
      };

  @override
  String toString() {
    // TODO: implement toString
    return 'name: $name, location $location, description $description, tags $tags';
  }
}
