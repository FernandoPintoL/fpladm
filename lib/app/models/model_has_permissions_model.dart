import 'dart:convert' as convert;

class ModelHasPermission {
  late int permissionId, modelId, teamId;
  late String modelType;

  ModelHasPermission({
    this.permissionId = 0,
    this.modelId = 0,
    this.teamId = 0,
    this.modelType = '',
  });

  ModelHasPermission.fromJson(Map<String, dynamic> json)
      : permissionId = int.tryParse(json['permission_id'].toString())!,
        modelId = int.tryParse(json['model_id'].toString())!,
        teamId = int.tryParse(json['team_id'].toString())!,
        modelType = json['model_type'].toString();

  Map<String, dynamic> toJson() => {
        'permission_id': permissionId.toString(),
        'model_id': modelId.toString(),
        'team_id': teamId.toString(),
        'model_type': modelType.toString()
      };

  static List<ModelHasPermission> parseArticulos(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<ModelHasPermission> list = parsed
        .map<ModelHasPermission>((json) => ModelHasPermission.fromJson(json))
        .toList();
    return list;
  }
}
