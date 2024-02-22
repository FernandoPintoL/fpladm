import 'dart:convert' as convert;

class Almacen {
  late int id, user_creacion_id, user_responsable_id;
  late String name, estado;
  late double capacidad_minima, capacidad_maxima;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  Almacen(
      {this.id = 0,
      this.user_creacion_id = 0,
      this.user_responsable_id = 0,
      this.name = "",
      this.capacidad_maxima = 0,
      this.capacidad_minima = 0,
      this.estado = "NO CREADO"});

  // CUANDO RECIVO DE MI API
  factory Almacen.fromJson(Map<String, dynamic> json) {
    Almacen object = Almacen(
        id: int.tryParse(json['id']!.toString())!,
        user_creacion_id: int.tryParse(json['user_creacion_id']!.toString())!,
        user_responsable_id:
            int.tryParse(json['user_responsable_id']!.toString())!,
        name: json['name'].toString(),
        capacidad_minima:
            double.tryParse(json['capacidad_minima']!.toString())!,
        capacidad_maxima:
            double.tryParse(json['capacidad_maxima']!.toString())!,
        estado: json['estado']);
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_creacion_id': user_creacion_id.toString(),
        'user_responsable_id': user_responsable_id.toString(),
        'name': name,
        'capacidad_minima': capacidad_minima.toString(),
        'capacidad_maxima': capacidad_maxima.toString(),
        'estado': estado,
      };

  static List<Almacen> parseStringToAlmacen(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Almacen> list =
        parsed.map<Almacen>((json) => Almacen.fromJson(json)).toList();
    return list;
  }

  List<Almacen> parseDynamicToAlmacen(dynamic listData) =>
      listData.map<Almacen>((e) => Almacen.fromJson(e)).toList();

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
