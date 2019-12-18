class User {
  final String firstName;
  final String lastName;

  final String position;
  final String company;

  final bool isSpeaker;
  final String imageUrl;

  User({
    this.firstName,
    this.lastName,
    this.position,
    this.company,
    this.isSpeaker,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      // id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      position: json['position'],
      company: json['company'],
      isSpeaker: json['is_speaker'],
      // imageUrl: json['image']
    );
  }

  String get fullName {
    return this.firstName.toString() + ' ' + this.lastName.toString();
  }
}
