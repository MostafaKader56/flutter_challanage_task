class UserModel {
  final String name;
  final String email;
  final String type;

  UserModel({required this.name, required this.email, required this.type});

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      type: json['type'] ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'type': type};
  }
}
