import 'dart:convert' as convert;

class Moneda {
  late int id;
  late String detalle, simbolo;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  Moneda({this.id = 0, this.detalle = "", this.simbolo = ""});

  // CUANDO RECIVO DE MI API
  factory Moneda.fromJson(Map<String, dynamic> json) {
    Moneda moneda = Moneda(
        id: int.tryParse(json['id']!.toString())!,
        detalle: json['detalle'].toString(),
        simbolo: json['simbolo'].toString());
    return moneda;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'detalle': detalle.toString(),
        'simbolo': simbolo.toString()
      };

  static List<Moneda> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Moneda> list =
        parsed.map<Moneda>((json) => Moneda.fromJson(json)).toList();
    return list;
  }

  List<Moneda> parseDynamicToList(dynamic listData) =>
      listData.map<Moneda>((e) => Moneda.fromJson(e)).toList();

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
