class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? image;

  User({this.id, this.firstName, this.lastName, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    image = json['image'];
  }

  toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'image': image,
    };
  }
}
