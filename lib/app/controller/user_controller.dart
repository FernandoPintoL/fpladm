import 'dart:io';

import '../models/http_response.dart';
import '../models/user_model.dart';
import 'request_controller.dart';

class UserController with RequestController {
  List<Usuario> lista = [];
  String apiRoute = 'users';

  Future<HttpResponsse> insertar(Usuario user) async {
    print(user.toString());
    return await insertResponse(apiRoute, user.toJson());
  }

  Future<HttpResponsse> actualizar(Usuario user) async {
    return await actualizarResponse(apiRoute, user.toJson(), user.id);
  }

  Future<HttpResponsse> delete(Usuario user) async {
    return await deleteResponse("$apiRoute/${user.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> updatePassword(
      Map<String, dynamic> data, Usuario user) async {
    print(data.toString());
    return await actualizarResponse('$apiRoute/password', data, user.id);
  }

  Future<HttpResponsse> cargarImage(int id, File file) async {
    return await subirfile('$apiRoute/subirimage', file, id);
  }
}
