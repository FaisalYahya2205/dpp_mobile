// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

class Session {
  String? id;
  int? user_id;
  int? partner_id;
  String? user_login;
  String? user_name;
  String? password;
  
  Session({
    this.id,
    this.user_id,
    this.partner_id,
    this.user_login,
    this.user_name,
    this.password,
  });

  Session copyWith({
    String? id,
    int? user_id,
    int? partner_id,
    String? user_login,
    String? user_name,
    String? password,
  }) {
    return Session(
      id: id ?? this.id,
      user_id: user_id ?? this.user_id,
      partner_id: partner_id ?? this.partner_id,
      user_login: user_login ?? this.user_login,
      user_name: user_name ?? this.user_name,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'user_id': user_id,
      'partner_id': partner_id,
      'user_login': user_login,
      'user_name': user_name,
      'password': password,
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      id: map['id'] != null ? map['id'] as String : null,
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      partner_id: map['partner_id'] != null ? map['partner_id'] as int : null,
      user_login: map['user_login'] != null ? map['user_login'] as String : null,
      user_name: map['user_name'] != null ? map['user_name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Session.fromJson(String source) =>
      Session.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Session(id: $id, user_id: $user_id, partner_id: $partner_id, user_login: $user_login, user_name: $user_name, password: $password)';
  }

  @override
  bool operator ==(covariant Session other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.user_id == user_id &&
      other.partner_id == partner_id &&
      other.user_login == user_login &&
      other.user_name == user_name &&
      other.password == password;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      user_id.hashCode ^
      partner_id.hashCode ^
      user_login.hashCode ^
      user_name.hashCode ^
      password.hashCode;
  }
}
