import 'dart:convert' as convert;

class Proveedor {
  late int id, perfil_id;
  late String propietario, nit, razon_social;
  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  dynamic nameError = "",
      descripcionError = "",
      precioCostoError = "",
      precioVentaError = "";

  Proveedor(
      {this.id = 0,
      this.perfil_id = 0,
      this.propietario = "",
      this.nit = "",
      this.razon_social = ""});

  // CUANDO RECIVO DE MI API
  factory Proveedor.fromJson(Map<String, dynamic> json) {
    Proveedor object = Proveedor(
        id: int.tryParse(json['id']!.toString())!,
        perfil_id: int.tryParse(json['perfil_id']!.toString())!,
        propietario: json['propietario'].toString(),
        nit: json['nit'].toString(),
        razon_social: json['razon_social'].toString());
    return object;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'perfil_id': perfil_id.toString(),
        'propietario': propietario.toString(),
        'nit': nit.toString()
      };

  static List<Proveedor> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Proveedor> list =
        parsed.map<Proveedor>((json) => Proveedor.fromJson(json)).toList();
    return list;
  }

  List<Proveedor> parseDynamicToList(dynamic listData) =>
      listData.map<Proveedor>((e) => Proveedor.fromJson(e)).toList();

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
