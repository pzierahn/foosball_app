class User {
  User({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory User.fromFirestore(Map<String, dynamic> json) => User(
        id: json["id"] as String,
        name: json["name"] as String,
      );
}
