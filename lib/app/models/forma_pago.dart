import 'dart:convert' as convert;

class FormaPago {
  late int id;
  late String detalle;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  FormaPago({this.id = 0, this.detalle = ""});

  // CUANDO RECIVO DE MI API
  factory FormaPago.fromJson(Map<String, dynamic> json) {
    FormaPago formaPago = FormaPago(
        id: int.tryParse(json['id']!.toString())!,
        detalle: json['detalle'].toString());
    return formaPago;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() =>
      {'id': id.toString(), 'detalle': detalle.toString()};

  static List<FormaPago> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<FormaPago> list =
        parsed.map<FormaPago>((json) => FormaPago.fromJson(json)).toList();
    return list;
  }

  List<FormaPago> parseDynamicToList(dynamic listData) =>
      listData.map<FormaPago>((e) => FormaPago.fromJson(e)).toList();

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
