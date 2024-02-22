import 'dart:convert' as convert;

class Item {
  late int id;
  late String detalle, photoPath;
  late double precioCosto, precioVenta;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();
  bool isHabilitado;

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  Item(
      {this.id = 0,
      this.detalle = '',
      this.photoPath = "",
      this.precioCosto = 0,
      this.precioVenta = 0,
      this.isHabilitado = false});

  // CUANDO RECIVO DE MI API
  factory Item.fromJson(Map<String, dynamic> json) {
    Item object = Item(
        id: int.tryParse(json['id'].toString())!,
        detalle: json['detalle'].toString(),
        precioCosto: double.tryParse(json['precio_costo']!.toString())!,
        precioVenta: double.tryParse(json['precio_venta']!.toString())!,
        photoPath: json['photo_path'].toString(),
        isHabilitado:
            int.tryParse(json['isHabilitado']!.toString()) == 1 ? true : false);
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'detalle': detalle,
        'precio_costo': precioCosto.toString(),
        'precio_venta': precioVenta.toString(),
        'photo_path': photoPath,
        'isHabilitado': isHabilitado ? '1' : '0',
      };

  static List<Item> parseStringToItem(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Item> list = parsed.map<Item>((json) => Item.fromJson(json)).toList();
    return list;
  }

  List<Item> parseDynamicToItem(dynamic listData) =>
      listData.map<Item>((e) => Item.fromJson(e)).toList();

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
