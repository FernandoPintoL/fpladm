import 'dart:convert' as convert;

class ModelHasPermission {
  late int permission_id, model_id, team_id;
  late String model_type;

  ModelHasPermission(
      {this.permission_id = 0,
      this.model_id = 0,
      this.team_id = 0,
      this.model_type = ""});

  // CUANDO RECIVO DE MI API
  factory ModelHasPermission.fromJson(Map<String, dynamic> json) {
    ModelHasPermission object = ModelHasPermission(
        permission_id: int.tryParse(json['permission_id']!.toString())!,
        model_id: int.tryParse(json['model_id']!.toString())!,
        team_id: int.tryParse(json['team_id']!.toString())!,
        model_type: json['model_type'].toString());
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'permission_id': permission_id.toString(),
        'model_id': model_id.toString(),
        'team_id': team_id.toString(),
        'model_type': model_type.toString()
      };

  static List<ModelHasPermission> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<ModelHasPermission> list = parsed
        .map<ModelHasPermission>((json) => ModelHasPermission.fromJson(json))
        .toList();
    return list;
  }

  List<ModelHasPermission> parseDynamicToList(dynamic listData) => listData
      .map<ModelHasPermission>((e) => ModelHasPermission.fromJson(e))
      .toList();

  @override
  String toString() {
    return toJson().toString();
  }
}
