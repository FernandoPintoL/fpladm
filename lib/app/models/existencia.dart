import 'dart:convert' as convert;

class Existencia {
  late int id, almacen_id, item_id;
  late double existencia, existencia_maxima, existencia_minima;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  Existencia(
      {this.id = 0,
      this.almacen_id = 0,
      this.item_id = 0,
      this.existencia = 0,
      this.existencia_minima = 0,
      this.existencia_maxima = 0});

  // CUANDO RECIVO DE MI API
  factory Existencia.fromJson(Map<String, dynamic> json) {
    Existencia object = Existencia(
        id: int.tryParse(json['id']!.toString())!,
        almacen_id: int.tryParse(json['almacen_id']!.toString())!,
        item_id: int.tryParse(json['item_id']!.toString())!,
        existencia: double.tryParse(json['existencia']!.toString())!,
        existencia_minima:
            double.tryParse(json['existencia_minima']!.toString())!,
        existencia_maxima:
            double.tryParse(json['existencia_maxima']!.toString())!);
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'almacen_id': almacen_id.toString(),
        'item_id': item_id.toString(),
        'existencia': existencia.toString(),
        'existencia_minima': existencia_minima.toString(),
        'existencia_maxima': existencia_maxima.toString(),
      };

  static List<Existencia> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Existencia> list =
        parsed.map<Existencia>((json) => Existencia.fromJson(json)).toList();
    return list;
  }

  List<Existencia> parseDynamicToList(dynamic listData) =>
      listData.map<Existencia>((e) => Existencia.fromJson(e)).toList();

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
