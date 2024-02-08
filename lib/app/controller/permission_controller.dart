import '../models/http_response.dart';
import '../models/permission_model.dart';
import 'request_controller.dart';

class PermissionController with RequestController {
  List<Permission> lista = [];
  String apiRoute = 'permission';

  Future<HttpResponsse> insertar(Permission permission) async {
    print(permission.toString());
    return await insertResponse(apiRoute, permission.toJson());
  }

  Future<HttpResponsse> actualizar(Permission permission) async {
    return await actualizarResponse(
        apiRoute, permission.toJson(), permission.id);
  }

  Future<HttpResponsse> delete(Permission permission) async {
    return await deleteResponse("$apiRoute/${permission.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }
}
