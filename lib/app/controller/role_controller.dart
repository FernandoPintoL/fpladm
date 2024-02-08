import '../models/http_response.dart';
import '../models/rol_model.dart';
import 'request_controller.dart';

class RoleController with RequestController {
  List<Rol> lista = [];
  String apiRoute = 'role';

  Future<HttpResponsse> insertar(Rol role) async {
    print(role.toString());
    return await insertResponse(apiRoute, role.toJson());
  }

  Future<HttpResponsse> actualizar(Rol role) async {
    return await actualizarResponse(apiRoute, role.toJson(), role.id);
  }

  Future<HttpResponsse> delete(Rol role) async {
    return await deleteResponse("$apiRoute/${role.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }
}
