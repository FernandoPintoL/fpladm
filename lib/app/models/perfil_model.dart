import 'dart:convert' as convert;

class Perfil {
  late int id;
  late String nombre, email, direccion, celular, photoUrl, estado;

  Perfil(
      {this.id = 0,
      this.nombre = '',
      this.email = '',
      this.direccion = '',
      this.celular = '',
      this.photoUrl = '',
      this.estado = "R"});

  factory Perfil.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return Perfil();
    } else {
      return Perfil(
          id: int.tryParse(json['id'].toString())!,
          nombre: json['name'].toString(),
          email: json['email'].toString(),
          direccion: json['direccion'].toString(),
          celular: json['celular'].toString(),
          photoUrl: json['photoUrl'].toString(),
          estado: json['estado']);
    }
  }

  /*: id = int.tryParse(json['id'].toString())!,
        nombre = json['nombre'].toString(),
        email = json['email'].toString(),
        direccion = json['direccion'].toString(),
        celular = json['celular'].toString(),
        photoUrl = json['photoUrl'].toString(),
        estado = json['estado'];*/

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': nombre.toString(),
        'email': email.toString(),
        'direccion': direccion.toString(),
        'celular': celular.toString(),
        'photoUrl': photoUrl.toString(),
        'estado': estado.toString()
      };

  static List<Perfil> parseStringToList(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Perfil> list =
        parsed.map<Perfil>((json) => Perfil.fromJson(json)).toList();
    return list;
  }

  List<Perfil> parseDynamicToList(dynamic listData) =>
      listData.map<Perfil>((e) => Perfil.fromJson(e)).toList();

  @override
  String toString() {
    return toJson().toString();
  }
}
