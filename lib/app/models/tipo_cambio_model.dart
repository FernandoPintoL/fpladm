import 'dart:convert' as convert;

class TipoCambio {
  late int id, user_creacion_id, moneda_id;
  late double tipo_cambio;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  TipoCambio(
      {this.id = 0,
      this.user_creacion_id = 0,
      this.moneda_id = 0,
      this.tipo_cambio = 0});

  // CUANDO RECIVO DE MI API
  factory TipoCambio.fromJson(Map<String, dynamic> json) {
    TipoCambio object = TipoCambio(
        id: int.tryParse(json['id']!.toString())!,
        user_creacion_id: int.tryParse(json['user_creacion_id']!.toString())!,
        moneda_id: int.tryParse(json['moneda_id']!.toString())!,
        tipo_cambio: double.tryParse(json['propietario']!.toString())!);
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_creacion_id': user_creacion_id.toString(),
        'moneda_id': moneda_id.toString(),
        'tipo_cambio': tipo_cambio.toString()
      };

  static List<TipoCambio> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<TipoCambio> list =
        parsed.map<TipoCambio>((json) => TipoCambio.fromJson(json)).toList();
    return list;
  }

  List<TipoCambio> parseDynamicToList(dynamic listData) =>
      listData.map<TipoCambio>((e) => TipoCambio.fromJson(e)).toList();

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
