// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] == false ? 0 : (json['id'] as num).toInt(),
      partnerId: json['partner_id'] == false ? 0 : (json['partner_id'] as num).toInt(),
      username: json['username'] == false ? "" : json['username'] as String,
      password: json['password'] == false ? "" : json['password'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'partner_id': instance.partnerId,
      'username': instance.username,
      'password': instance.password,
    };
