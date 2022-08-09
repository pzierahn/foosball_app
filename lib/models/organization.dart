import 'package:kicker_app/models/user.dart';

class Organization {
  Organization({
    required this.id,
    required this.users,
    required this.silos,
  });

  final String id;
  final Map<String, User> users;
  final Map<String, int> silos;

  factory Organization.fromFirestore(Map<String, dynamic> data) => Organization(
        id: data["id"] ?? "",
        silos: Map<String, int>.from((data["silos"] ?? {}).map(
          (key, value) => MapEntry<String, int>(key as String, value as int),
        )),
        users: Map<String, User>.from((data["users"] ?? {}).map(
          (key, value) => MapEntry<String, User>(
            key,
            User.fromFirestore(value),
          ),
        )),
      );
}
