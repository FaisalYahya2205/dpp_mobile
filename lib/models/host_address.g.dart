// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostAddress _$HostAddressFromJson(Map<String, dynamic> json) => HostAddress(
      userId: json['user_id'] == false ? null : json['user_id'] as int?,
      hostUrl: json['host_url'] == false ? null : json['host_url'] as String?,
      databaseName: json['database_name'] == false
          ? null
          : json['database_name'] as String?,
    );

Map<String, dynamic> _$HostAddressToJson(HostAddress instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'host_url': instance.hostUrl,
      'database_name': instance.databaseName,
    };
