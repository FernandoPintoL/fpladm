import 'dart:convert' as convert;

class Compra {
  late int id, user_creacion_id, proveedor_id, forma_pago_id, moneda_id;
  late String detalle, estado;
  late double monto_total, monto_descuento;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  Compra(
      {this.id = 0,
      this.user_creacion_id = 0,
      this.proveedor_id = 0,
      this.forma_pago_id = 0,
      this.moneda_id = 0,
      this.detalle = "",
      this.estado = "NO CREADO",
      this.monto_total = 0,
      this.monto_descuento = 0});

  // CUANDO RECIVO DE MI API
  factory Compra.fromJson(Map<String, dynamic> json) {
    Compra compra = Compra(
        id: int.tryParse(json['id']!.toString())!,
        user_creacion_id: int.tryParse(json['user_creacion_id']!.toString())!,
        proveedor_id: int.tryParse(json['proveedor_id']!.toString())!,
        forma_pago_id: int.tryParse(json['forma_pago_id']!.toString())!,
        moneda_id: int.tryParse(json['moneda_id']!.toString())!,
        detalle: json['detalle'].toString(),
        estado: json['estado'].toString(),
        monto_total: double.tryParse(json['monto_total']!.toString())!,
        monto_descuento: double.tryParse(json['monto_descuento']!.toString())!);
    return compra;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_creacion_id': user_creacion_id.toString(),
        'proveedor_id': proveedor_id.toString(),
        'forma_pago_id': forma_pago_id.toString(),
        'moneda_id': moneda_id.toString(),
        'monto_total': monto_total.toString(),
        'monto_descuento': monto_descuento.toString(),
        'detalle': detalle.toString(),
        'estado': estado
      };

  static List<Compra> parseStringToAlmacen(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Compra> list =
        parsed.map<Compra>((json) => Compra.fromJson(json)).toList();
    return list;
  }

  List<Compra> parseDynamicToAlmacen(dynamic listData) =>
      listData.map<Compra>((e) => Compra.fromJson(e)).toList();

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
