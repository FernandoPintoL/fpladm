import 'dart:convert' as convert;
import 'perfil_model.dart';

class Empresa {
  late int id, user_id, perfil_id;
  String propietario, nit, razon_social;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();
  dynamic nombreError = "",
      userloginError = "",
      emailError = "",
      passwordError = "";
  DateTime now = DateTime.now();
  Perfil perfil = Perfil();

  Empresa(
      {this.id = 0,
      this.user_id = 0,
      this.perfil_id = 0,
      this.propietario = "",
      this.nit = "",
      this.razon_social = ""});

  // CUANDO RECIVO DE MI API
  factory Empresa.fromJson(Map<String, dynamic> json) {
    Empresa object = Empresa(
        id: int.tryParse(json['id']!.toString())!,
        user_id: int.tryParse(json['user_id']!.toString())!,
        perfil_id: int.tryParse(json['perfil_id']!.toString())!,
        propietario: json['propietario'].toString(),
        nit: json['nit'].toString(),
        razon_social: json['razon_social'].toString());
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_id': user_id.toString(),
        'perfil_id': perfil_id.toString(),
        'propietario': propietario.toString(),
        'razon_social': razon_social.toString(),
        'nit': nit.toString()
      };

  static List<Empresa> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Empresa> list =
        parsed.map<Empresa>((json) => Empresa.fromJson(json)).toList();
    return list;
  }

  List<Empresa> parseDynamicToList(dynamic listData) =>
      listData.map<Empresa>((e) => Empresa.fromJson(e)).toList();

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
