import '../models/cliente_model.dart';
import '../models/http_response.dart';
import 'request_controller.dart';

class ClienteController with RequestController {
  List<Cliente> lista = [];
  String apiRoute = 'clientes';

  Future<HttpResponsse> insertar(Cliente data) async {
    print(data.toString());
    return await insertResponse(apiRoute, data.toJson());
  }

  Future<HttpResponsse> actualizar(Cliente data) async {
    return await actualizarResponse(apiRoute, data.toJson(), data.id);
  }

  Future<HttpResponsse> delete(Cliente data) async {
    return await deleteResponse("$apiRoute/${data.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> show(String id) async {
    return await getResponse('$apiRoute/$id');
  }
}
