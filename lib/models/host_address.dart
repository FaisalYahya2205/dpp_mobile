// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'host_address.g.dart';

/// Model class representing a host address configuration
@JsonSerializable(fieldRename: FieldRename.snake)
class HostAddress {
  final int? userId;
  final String? hostUrl;
  final String? databaseName;

  const HostAddress({
    this.userId,
    this.hostUrl,
    this.databaseName,
  });

  HostAddress copyWith({
    int? userId,
    String? hostUrl,
    String? databaseName,
  }) {
    return HostAddress(
      userId: userId ?? this.userId,
      hostUrl: hostUrl ?? this.hostUrl,
      databaseName: databaseName ?? this.databaseName,
    );
  }

  factory HostAddress.fromJson(String source) => 
      _$HostAddressFromJson(json.decode(source) as Map<String, dynamic>);

  String toJson() => json.encode(_$HostAddressToJson(this));

  @override
  String toString() => 'HostAddress(userId: $userId, hostUrl: $hostUrl, databaseName: $databaseName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HostAddress &&
        other.userId == userId &&
        other.hostUrl == hostUrl &&
        other.databaseName == databaseName;
  }

  @override
  int get hashCode => Object.hashAll([userId, hostUrl, databaseName]);
}
