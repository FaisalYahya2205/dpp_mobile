// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

/// Model class representing a user session
@JsonSerializable(fieldRename: FieldRename.snake)
class Session {
  final String? sessionId;
  final int? userId;
  final int? partnerId;
  final String? userLogin;
  final String? userName;
  final String? password;
  final int? loginState;
  
  const Session({
    this.sessionId,
    this.userId,
    this.partnerId,
    this.userLogin,
    this.userName,
    this.password,
    this.loginState,
  });

  Session copyWith({
    String? sessionId,
    int? userId,
    int? partnerId,
    String? userLogin,
    String? userName,
    String? password,
    int? loginState,
  }) {
    return Session(
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      partnerId: partnerId ?? this.partnerId,
      userLogin: userLogin ?? this.userLogin,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      loginState: loginState ?? this.loginState,
    );
  }

  factory Session.fromJson(String source) => 
      _$SessionFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$SessionToJson(this));

  @override
  String toString() {
    return 'Session(sessionId: $sessionId, userId: $userId, partnerId: $partnerId, userLogin: $userLogin, userName: $userName, password: $password, loginState: $loginState)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Session &&
        other.sessionId == sessionId &&
        other.userId == userId &&
        other.partnerId == partnerId &&
        other.userLogin == userLogin &&
        other.userName == userName &&
        other.password == password &&
        other.loginState == loginState;
  }

  @override
  int get hashCode {
    return Object.hashAll([
      sessionId,
      userId,
      partnerId,
      userLogin,
      userName,
      password,
      loginState,
    ]);
  }
}
