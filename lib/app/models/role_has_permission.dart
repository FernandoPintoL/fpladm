import 'dart:convert' as convert;

class RoleHasPermission {
  late int permission_id, role_id;

  RoleHasPermission({this.role_id = 0, this.permission_id = 0});

  // CUANDO RECIVO DE MI API
  factory RoleHasPermission.fromJson(Map<String, dynamic> json) {
    RoleHasPermission object = RoleHasPermission(
        permission_id: int.tryParse(json['permission_id']!.toString())!,
        role_id: int.tryParse(json['role_id']!.toString())!);
    return object;
  }

  Map<String, dynamic> toJson() => {
        'permission_id': permission_id.toString(),
        'role_id': role_id.toString()
      };

  static List<RoleHasPermission> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<RoleHasPermission> list = parsed
        .map<RoleHasPermission>((json) => RoleHasPermission.fromJson(json))
        .toList();
    return list;
  }

  List<RoleHasPermission> parseDynamicToList(dynamic listData) => listData
      .map<RoleHasPermission>((e) => RoleHasPermission.fromJson(e))
      .toList();

  @override
  String toString() {
    return toJson().toString();
  }
}
