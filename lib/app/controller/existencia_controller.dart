import '../models/existencia.dart';
import '../models/http_response.dart';
import 'request_controller.dart';

class ExistenciaController with RequestController {
  List<Existencia> lista = [];
  String apiRoute = 'existencias';

  Future<HttpResponsse> insertar(Existencia data) async {
    print(data.toString());
    return await insertResponse(apiRoute, data.toJson());
  }

  Future<HttpResponsse> actualizar(Existencia data) async {
    return await actualizarResponse(apiRoute, data.toJson(), data.id);
  }

  Future<HttpResponsse> delete(Existencia data) async {
    return await deleteResponse("$apiRoute/${data.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> show(String id) async {
    return await getResponse('$apiRoute/$id');
  }
}
