import 'dart:convert' as convert;
import 'perfil_model.dart';

class Empresa {
  late int id, userId, perfilId;
  String propietario, nit, razonSocial;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();
  dynamic nombreError = "",
      userloginError = "",
      emailError = "",
      passwordError = "";
  DateTime now = DateTime.now();
  Perfil perfil = Perfil();

  Empresa(
      {this.id = 0,
      this.userId = 0,
      this.perfilId = 0,
      this.propietario = "",
      this.nit = "",
      this.razonSocial = ""});

  Empresa.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json['id'].toString())!,
        userId = int.tryParse(json['user_id'].toString())!,
        perfilId = int.tryParse(json['perfil_id'].toString())!,
        propietario = json['propietario'].toString(),
        nit = json['nit'].toString(),
        razonSocial = json['razonSocial'].toString(),
        perfil =
            json["perfil"] == null ? Perfil() : Perfil.fromJson(json["perfil"]);

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_id': userId.toString(),
        'perfil_id': perfilId.toString(),
        'propietario': propietario,
        'nit': nit,
        'razonSocial': razonSocial,
        'perfil': perfil.toJson()
      };

  static List<Empresa> parseUsuarios(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Empresa> list =
        parsed.map<Empresa>((json) => Empresa.fromJson(json)).toList();
    return list;
  }

  List<Empresa> parseUsers(dynamic listData) {
    return listData.map<Empresa>((e) => Empresa.fromJson(e)).toList();
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
