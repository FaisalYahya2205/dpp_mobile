// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

List<String> getUserFields() => ['id', 'partner_id'];

class User {
  int id;
  int partner_id;
  String username;
  String password;

  User({
    required this.id,
    required this.partner_id,
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'partner_id': partner_id,
      'username': username,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      partner_id: map['partner_id'] as int,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, partner_id: $partner_id, username: $username, password: $password)';
  }

  User copyWith({
    int? id,
    int? partner_id,
    String? username,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      partner_id: partner_id ?? this.partner_id,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
