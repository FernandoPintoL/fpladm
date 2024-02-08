import 'dart:convert' as convert;
import 'perfil_model.dart';

class Cliente {
  late int id, userId, perfilId;
  String ci;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();
  dynamic nombreError = "",
      userloginError = "",
      emailError = "",
      passwordError = "";
  DateTime now = DateTime.now();
  Perfil perfil = Perfil();

  Cliente({
    this.id = 0,
    this.userId = 0,
    this.perfilId = 0,
    this.ci = "",
  });

  Cliente.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json['id'].toString())!,
        userId = int.tryParse(json['user_id'].toString())!,
        perfilId = int.tryParse(json['perfil_id'].toString())!,
        ci = json['ci'].toString(),
        perfil =
            json["perfil"] == null ? Perfil() : Perfil.fromJson(json["perfil"]);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_id': userId.toString(),
        'perfil_id': perfilId.toString(),
        'propietario': ci.toString(),
        'perfil': perfil.toJson()
      };

  static List<Cliente> parseUsuarios(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Cliente> list =
        parsed.map<Cliente>((json) => Cliente.fromJson(json)).toList();
    return list;
  }

  List<Cliente> parseUsers(dynamic listData) {
    return listData.map<Cliente>((e) => Cliente.fromJson(e)).toList();
  }

  String fechaCreado() {
    return '${creado.day}/${creado.month}/${creado.year}';
  }

  String horaCreado() {
    String hora = creado.hour < 10 ? '0${creado.hour}' : creado.hour.toString();
    String minuto =
        creado.minute < 10 ? '0${creado.minute}' : creado.minute.toString();
    return "$hora:$minuto";
  }

  String fechaActualizado() {
    return '${actualizado.day}/${actualizado.month}/${actualizado.year}';
  }

  String horaActualizado() {
    String hora = actualizado.hour < 10
        ? '0${actualizado.hour}'
        : actualizado.hour.toString();
    String minuto = actualizado.minute < 10
        ? '0${actualizado.minute}'
        : actualizado.minute.toString();
    return "$hora:$minuto";
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
