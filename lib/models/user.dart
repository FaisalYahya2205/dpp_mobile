// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// List of field names used in the User model
List<String> getUserFields() => ['id', 'partner_id', 'username', 'password'];

/// Model class representing a user
@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final int id;
  final int partnerId;
  final String username;
  final String password;

  const User({
    required this.id,
    required this.partnerId,
    required this.username,
    required this.password,
  });

  User copyWith({
    int? id,
    int? partnerId,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      partnerId: partnerId ?? this.partnerId,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  factory User.fromJson(String source) => 
      _$UserFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$UserToJson(this));

  @override
  String toString() {
    return 'User(id: $id, partner_id: $partnerId, username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.partnerId == partnerId &&
        other.username == username &&
        other.password == password;
  }

  @override
  int get hashCode => Object.hashAll([id, partnerId, username, password]);
}
