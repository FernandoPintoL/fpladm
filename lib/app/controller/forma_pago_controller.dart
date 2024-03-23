import '../models/forma_pago.dart';
import '../models/http_response.dart';
import 'request_controller.dart';

class FormaPagoController with RequestController {
  List<FormaPago> lista = [];
  String apiRoute = 'formapagos';

  Future<HttpResponsse> insertar(FormaPago data) async {
    print(data.toString());
    return await insertResponse(apiRoute, data.toJson());
  }

  Future<HttpResponsse> actualizar(FormaPago data) async {
    return await actualizarResponse(apiRoute, data.toJson(), data.id);
  }

  Future<HttpResponsse> delete(FormaPago data) async {
    return await deleteResponse("$apiRoute/${data.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> show(String id) async {
    return await getResponse('$apiRoute/$id');
  }
}
