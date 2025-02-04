// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class HostAddress {
  int? user_id;
  String? host_url;
  String? database_name;

  HostAddress({
    this.user_id,
    this.host_url,
    this.database_name,
  });

  HostAddress copyWith({
    int? user_id,
    String? host_url,
    String? database_name,
  }) {
    return HostAddress(
      user_id: user_id ?? this.user_id,
      host_url: host_url ?? this.host_url,
      database_name: database_name ?? this.database_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': user_id,
      'host_url': host_url,
      'database_name': database_name,
    };
  }

  factory HostAddress.fromMap(Map<String, dynamic> map) {
    return HostAddress(
      user_id: map['user_id'] != null ? map['user_id'] as int : null,
      host_url: map['host_url'] != null ? map['host_url'] as String : null,
      database_name: map['database_name'] != null ? map['database_name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HostAddress.fromJson(String source) => HostAddress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'HostAddress(user_id: $user_id, host_url: $host_url, database_name: $database_name)';

  @override
  bool operator ==(covariant HostAddress other) {
    if (identical(this, other)) return true;
  
    return 
      other.user_id == user_id &&
      other.host_url == host_url &&
      other.database_name == database_name;
  }

  @override
  int get hashCode => user_id.hashCode ^ host_url.hashCode ^ database_name.hashCode;
}
