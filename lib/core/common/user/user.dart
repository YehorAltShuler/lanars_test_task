// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  @Id()
  int id;
  String username;
  String email;
  String profilePictureUrl;

  User({
    this.id = 0,
    required this.username,
    required this.email,
    required this.profilePictureUrl,
  });

  User copyWith({
    String? username,
    String? email,
    String? profilePictureUrl,
  }) {
    return User(
      username: username ?? this.username,
      email: email ?? this.email,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    // Берем первый объект из списка results
    final userData = (map['results'] as List).first;

    return User(
      username: userData['login']['username'] as String,
      email: userData['email'] as String,
      profilePictureUrl: userData['picture']['large'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(username: $username, email: $email, profilePictureUrl: $profilePictureUrl)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.profilePictureUrl == profilePictureUrl;
  }

  @override
  int get hashCode =>
      username.hashCode ^ email.hashCode ^ profilePictureUrl.hashCode;
}
