import 'dart:convert' as convert;

class DetalleVenta {
  late int id, venta_id, item_id;
  late double sub_total, cantidad;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  DetalleVenta(
      {this.id = 0,
      this.venta_id = 0,
      this.item_id = 0,
      this.sub_total = 0,
      this.cantidad = 0});

  // CUANDO RECIVO DE MI API
  factory DetalleVenta.fromJson(Map<String, dynamic> json) {
    DetalleVenta object = DetalleVenta(
        id: int.tryParse(json['id']!.toString())!,
        venta_id: int.tryParse(json['venta_id']!.toString())!,
        item_id: int.tryParse(json['item_id']!.toString())!,
        sub_total: double.tryParse(json['sub_total']!.toString())!,
        cantidad: double.tryParse(json['cantidad']!.toString())!);
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'venta_id': venta_id.toString(),
        'item_id': item_id.toString(),
        'cantidad': cantidad.toString(),
        'sub_total': sub_total.toString()
      };

  static List<DetalleVenta> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<DetalleVenta> list = parsed
        .map<DetalleVenta>((json) => DetalleVenta.fromJson(json))
        .toList();
    return list;
  }

  List<DetalleVenta> parseDynamicToList(dynamic listData) =>
      listData.map<DetalleVenta>((e) => DetalleVenta.fromJson(e)).toList();

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
