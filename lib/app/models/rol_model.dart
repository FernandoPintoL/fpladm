import 'dart:convert' as convert;

class Rol {
  late int id;
  late String name, guard_name;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  Rol({this.id = 0, this.name = '', this.guard_name = ''});

  factory Rol.fromJson(Map<String, dynamic> json) {
    Rol object = Rol(
        id: int.tryParse(json['id']!.toString())!,
        name: json['name'].toString(),
        guard_name: json['guard_name'].toString());
    return object;
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name.toString(),
        'guard_name': guard_name.toString()
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
