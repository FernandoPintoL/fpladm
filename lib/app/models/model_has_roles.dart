import 'dart:convert' as convert;

class ModelHasRoles {
  late int role_id, model_id, team_id;
  late String model_type;

  ModelHasRoles({
    this.role_id = 0,
    this.model_id = 0,
    this.team_id = 0,
    this.model_type = '',
  });

  // CUANDO RECIVO DE MI API
  factory ModelHasRoles.fromJson(Map<String, dynamic> json) {
    ModelHasRoles object = ModelHasRoles(
        role_id: int.tryParse(json['role_id']!.toString())!,
        model_id: int.tryParse(json['model_id']!.toString())!,
        team_id: int.tryParse(json['team_id']!.toString())!,
        model_type: json['model_type'].toString());
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'role_id': role_id.toString(),
        'model_id': model_id.toString(),
        'team_id': team_id.toString(),
        'model_type': model_type.toString()
      };

  static List<ModelHasRoles> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<ModelHasRoles> list = parsed
        .map<ModelHasRoles>((json) => ModelHasRoles.fromJson(json))
        .toList();
    return list;
  }

  List<ModelHasRoles> parseDynamicToList(dynamic listData) =>
      listData.map<ModelHasRoles>((e) => ModelHasRoles.fromJson(e)).toList();

  @override
  String toString() {
    return toJson().toString();
  }
}
