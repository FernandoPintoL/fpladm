import '../models/almacen_model.dart';
import '../models/http_response.dart';
import '../models/model_has_permissions_model.dart';
import 'request_controller.dart';

class ModelHasPermissionController with RequestController {
  List<ModelHasPermission> lista = [];
  String apiRoute = 'almacenes';

  Future<HttpResponsse> insertar(ModelHasPermission data) async {
    print(data.toString());
    return await insertResponse(apiRoute, data.toJson());
  }

  Future<HttpResponsse> actualizar(ModelHasPermission data) async {
    return await actualizarResponse(apiRoute, data.toJson(), data.model_id);
  }

  Future<HttpResponsse> delete(ModelHasPermission data) async {
    return await deleteResponse("$apiRoute/${data.model_id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> show(String id) async {
    return await getResponse('$apiRoute/$id');
  }
}
