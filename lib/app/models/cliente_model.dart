import 'dart:convert' as convert;
import 'package:fpladm/app/models/user_model.dart';

import 'perfil_model.dart';

class Cliente {
  late int id, user_id, perfil_id;
  String ci;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();
  dynamic nombreError = "",
      userloginError = "",
      emailError = "",
      passwordError = "";

  DateTime now = DateTime.now();
  Perfil perfil = Perfil();
  Usuario user = Usuario();

  Cliente({
    this.id = 0,
    this.user_id = 0,
    this.perfil_id = 0,
    this.ci = "",
  });

  // CUANDO RECIVO DE MI API
  factory Cliente.fromJson(Map<String, dynamic> json) {
    Cliente object = Cliente(
        id: int.tryParse(json['id']!.toString())!,
        perfil_id: int.tryParse(json['perfil_id']!.toString())!,
        user_id: int.tryParse(json['user_id']!.toString())!,
        ci: json['ci'].toString());
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'perfil_id': perfil_id.toString(),
        'user_id': user_id.toString(),
        'ci': ci.toString()
      };

  static List<Cliente> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Cliente> list =
        parsed.map<Cliente>((json) => Cliente.fromJson(json)).toList();
    return list;
  }

  List<Cliente> parseDynamicToList(dynamic listData) =>
      listData.map<Cliente>((e) => Cliente.fromJson(e)).toList();

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
