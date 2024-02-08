import 'dart:convert' as convert;
import 'cliente_model.dart';
import 'empresa_model.dart';

class Usuario {
  late int id;
  late String name,
      userLogin,
      email,
      profilePhotoUrl,
      profilePhotoPath,
      password,
      passwordRepeat;

  DateTime creado = DateTime.now(), actualizado = DateTime.now();

  bool isHabilitado, isEmpresa, terms;

  dynamic nombreError = "",
      userloginError = "",
      emailError = "",
      passwordError = "";

  Empresa empresa = Empresa();
  Cliente cliente = Cliente();

  Usuario(
      {this.id = 0,
      this.name = '',
      this.email = '',
      this.userLogin = "",
      this.profilePhotoUrl = '',
      this.profilePhotoPath = '',
      this.password = '',
      this.passwordRepeat = '',
      this.isHabilitado = false,
      this.isEmpresa = false,
      this.terms = false});

  // CUANDO RECIVO DE MI API
  factory Usuario.fromJson(Map<String, dynamic> json) {
    Usuario usuario = Usuario(
      id: int.tryParse(json['id'].toString())!,
      name: json['name'].toString(),
      userLogin: json['userlogin'].toString(),
      email: json['email'].toString(),
      profilePhotoUrl: json['profile_photo_url'].toString(),
      profilePhotoPath: json['profile_photo_path'].toString(),
      isHabilitado:
          int.tryParse(json['isHabilitado']!.toString()) == 1 ? true : false,
      isEmpresa:
          int.tryParse(json['isEmpresa']!.toString()) == 1 ? true : false,
    );
    Empresa empresa =
        json["empresa"] == null ? Empresa() : Empresa.fromJson(json["empresa"]);
    usuario.empresa = empresa;
    return usuario;
  }

  //CUANDO ENVIO A MI API
  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'name': name,
        'userlogin': userLogin,
        'email': email,
        'password': password,
        'password_confirmation': passwordRepeat,
        'profile_photo_url': profilePhotoUrl,
        'profile_photo_path': profilePhotoPath,
        'isHabilitado': isHabilitado ? '1' : '0',
        'isEmpresa': isEmpresa ? '1' : '0',
        'terms': 'accepted'
      };

  static List<Usuario> parseUsuarios(String responseBody) {
    final parsed =
        convert.jsonDecode(responseBody).cast<Map<String, dynamic>>();
    List<Usuario> list =
        parsed.map<Usuario>((json) => Usuario.fromJson(json)).toList();
    return list;
  }

  List<Usuario> parseUsers(dynamic listData) {
    List<Usuario> lista =
        listData.map<Usuario>((e) => Usuario.fromJson(e)).toList();
    return lista;
  }

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
