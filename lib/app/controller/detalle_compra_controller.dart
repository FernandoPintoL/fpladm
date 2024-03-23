import '../models/detalle_compra.dart';
import '../models/http_response.dart';
import 'request_controller.dart';

class DetalleCompraController with RequestController {
  List<DetalleCompra> lista = [];
  String apiRoute = 'detallecompras';

  Future<HttpResponsse> insertar(DetalleCompra data) async {
    print(data.toString());
    return await insertResponse(apiRoute, data.toJson());
  }

  Future<HttpResponsse> actualizar(DetalleCompra data) async {
    return await actualizarResponse(apiRoute, data.toJson(), data.id);
  }

  Future<HttpResponsse> delete(DetalleCompra data) async {
    return await deleteResponse("$apiRoute/${data.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> show(String id) async {
    return await getResponse('$apiRoute/$id');
  }
}
