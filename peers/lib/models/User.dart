class User {
  String? id;
  String firstname;
  String lastname;
  String email;
  String? accessToken;
  String? password;
  String? gender;
  String? school;
  String? bio;
  List? events;

  User(
      {required this.firstname,
      required this.lastname,
      required this.email,
      this.accessToken,
      this.id,
      this.password,
      this.gender,
      this.school,
      this.bio,
      this.events});

  factory User.fromJson(Map<dynamic, dynamic> json) {
    print(json);
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      accessToken: json['accessToken'],
      gender: json['gender'],
      school: json['school'],
      bio: json['bio'],
      events: json['events'],
    );
  }

  factory User.fromLocalDB(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      gender: json['gender'],
      school: json['school'],
      bio: json['bio'],
      events: json['events'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "accessToken": accessToken,
        "gender": gender,
        "school": school,
        "bio": bio,
        "events": events,
      };

  Map<String, dynamic> toLocalDB() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "gender": gender,
        "school": school,
        "bio": bio,
        "events": events,
      };

  Map<String, dynamic> toDB() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "password": password,
        "gender": gender,
        "school": school,
        "bio": bio,
        "events": events,
      };

  @override
  String toString() {
    // TODO: implement toString
    return '${this.firstname} ${this.lastname} ${this.email} ${this.gender} ${this.school} ${this.bio}';
  }

  String initials() {
    return '${this.firstname[0].toUpperCase()}${this.lastname[0].toUpperCase()}';
  }
}
