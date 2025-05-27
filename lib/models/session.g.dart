// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      sessionId: json['session_id'] == false ? null : json['session_id'] as String?,
      userId: json['user_id'] == false ? null : json['user_id'] as int?,
      partnerId: json['partner_id'] == false ? null : json['partner_id'] as int?,
      userLogin: json['user_login'] == false ? null : json['user_login'] as String?,
      userName: json['user_name'] == false ? null : json['user_name'] as String?,
      password: json['password'] == false ? null : json['password'] as String?,
      loginState: json['login_state'] == false ? null : json['login_state'] as int?,
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'session_id': instance.sessionId,
      'user_id': instance.userId,
      'partner_id': instance.partnerId,
      'user_login': instance.userLogin,
      'user_name': instance.userName,
      'password': instance.password,
      'login_state': instance.loginState,
    };
