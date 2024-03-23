import '../models/detalle_venta.dart';
import '../models/http_response.dart';
import 'request_controller.dart';

class DetalleVentaController with RequestController {
  List<DetalleVenta> lista = [];
  String apiRoute = 'detalleventas';

  Future<HttpResponsse> insertar(DetalleVenta data) async {
    print(data.toString());
    return await insertResponse(apiRoute, data.toJson());
  }

  Future<HttpResponsse> actualizar(DetalleVenta data) async {
    return await actualizarResponse(apiRoute, data.toJson(), data.id);
  }

  Future<HttpResponsse> delete(DetalleVenta data) async {
    return await deleteResponse("$apiRoute/${data.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> show(String id) async {
    return await getResponse('$apiRoute/$id');
  }
}
