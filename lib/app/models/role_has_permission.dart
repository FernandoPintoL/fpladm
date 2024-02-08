import 'dart:convert' as convert;

class RoleHasPermission {
  late int permissionId, roleId;

  RoleHasPermission({this.roleId = 0, this.permissionId = 0});

  RoleHasPermission.fromJson(Map<String, dynamic> json)
      : permissionId = int.tryParse(json['permission_id'].toString())!,
        roleId = int.tryParse(json['role_id'].toString())!;

  Map<String, dynamic> toJson() =>
      {'permission_id': permissionId.toString(), 'role_id': roleId.toString()};

  static List<RoleHasPermission> parseArticulos(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<RoleHasPermission> list = parsed
        .map<RoleHasPermission>((json) => RoleHasPermission.fromJson(json))
        .toList();
    return list;
  }
}
