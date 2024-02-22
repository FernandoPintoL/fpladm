import 'dart:convert' as convert;

class Venta {
  late int id, user_creacion_id, cliente_id, forma_pago_id, moneda_id;
  late String detalle, estado;
  late double monto_total, monto_descuento;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  Venta(
      {this.id = 0,
      this.user_creacion_id = 0,
      this.cliente_id = 0,
      this.forma_pago_id = 0,
      this.moneda_id = 0,
      this.detalle = "",
      this.estado = "NO CREADO",
      this.monto_total = 0,
      this.monto_descuento = 0});

  // CUANDO RECIVO DE MI API
  factory Venta.fromJson(Map<String, dynamic> json) {
    Venta object = Venta(
        id: int.tryParse(json['id']!.toString())!,
        user_creacion_id: int.tryParse(json['user_creacion_id']!.toString())!,
        cliente_id: int.tryParse(json['cliente_id']!.toString())!,
        forma_pago_id: int.tryParse(json['forma_pago_id']!.toString())!,
        moneda_id: int.tryParse(json['moneda_id']!.toString())!,
        detalle: json['detalle'].toString(),
        estado: json['estado'].toString(),
        monto_total: double.tryParse(json['monto_total']!.toString())!,
        monto_descuento: double.tryParse(json['monto_descuento']!.toString())!);
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_creacion_id': user_creacion_id.toString(),
        'cliente_id': cliente_id.toString(),
        'forma_pago_id': forma_pago_id.toString(),
        'moneda_id': moneda_id.toString(),
        'monto_total': monto_total.toString(),
        'monto_descuento': monto_descuento.toString(),
        'detalle': detalle.toString(),
        'estado': estado
      };

  static List<Venta> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Venta> list =
        parsed.map<Venta>((json) => Venta.fromJson(json)).toList();
    return list;
  }

  List<Venta> parseDynamicToList(dynamic listData) =>
      listData.map<Venta>((e) => Venta.fromJson(e)).toList();

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
