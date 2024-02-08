import 'dart:convert' as convert;

class Rol {
  late int id;

  late String name, guardName;

  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  Rol({this.id = 0, this.name = '', this.guardName = ''});

  Rol.fromJson(Map<String, dynamic> json)
      : id = int.tryParse(json['id'].toString())!,
        name = json['name'].toString(),
        guardName = json['guard_name'].toString(),
        creado = DateTime.parse(json['created_at'].toString()),
        actualizado = DateTime.parse(json['updated_at'].toString());

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name.toString(),
        'guard_name': guardName.toString()
      };

  static List<Rol> parseResponseBody(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Rol> list = parsed.map<Rol>((json) => Rol.fromJson(json)).toList();
    return list;
  }

  List<Rol> parseRol(dynamic listData) {
    return listData.map<Rol>((e) => Rol.fromJson(e)).toList();
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
