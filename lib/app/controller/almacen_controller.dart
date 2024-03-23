import '../models/almacen_model.dart';
import '../models/http_response.dart';
import 'request_controller.dart';

class AlmacenController with RequestController {
  List<Almacen> lista = [];
  String apiRoute = 'almacenes';

  Future<HttpResponsse> insertar(Almacen data) async {
    print(data.toString());
    return await insertResponse(apiRoute, data.toJson());
  }

  Future<HttpResponsse> actualizar(Almacen data) async {
    return await actualizarResponse(apiRoute, data.toJson(), data.id);
  }

  Future<HttpResponsse> delete(Almacen data) async {
    return await deleteResponse("$apiRoute/${data.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> show(String id) async {
    return await getResponse('$apiRoute/$id');
  }
}
