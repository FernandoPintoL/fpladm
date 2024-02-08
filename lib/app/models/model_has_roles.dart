import 'dart:convert' as convert;

class ModelHasRoles {
  late int roleId, modelId, teamId;
  late String modelType;

  ModelHasRoles({
    this.roleId = 0,
    this.modelId = 0,
    this.teamId = 0,
    this.modelType = '',
  });

  ModelHasRoles.fromJson(Map<String, dynamic> json)
      : roleId = int.tryParse(json['role_id'].toString())!,
        modelId = int.tryParse(json['model_id'].toString())!,
        teamId = int.tryParse(json['team_id'].toString())!,
        modelType = json['model_type'].toString();

  Map<String, dynamic> toJson() => {
        'role_id': roleId.toString(),
        'model_id': modelId.toString(),
        'team_id': teamId.toString(),
        'model_type': modelType.toString()
      };

  static List<ModelHasRoles> parseArticulos(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<ModelHasRoles> list = parsed
        .map<ModelHasRoles>((json) => ModelHasRoles.fromJson(json))
        .toList();
    return list;
  }
}
