import '../models/empresa_model.dart';
import '../models/http_response.dart';
import 'request_controller.dart';

class EmpresaController with RequestController {
  List<Empresa> lista = [];
  String apiRoute = 'empresa';

  Future<HttpResponsse> insertar(Empresa empresa) async {
    print(empresa.toString());
    return await insertResponse(apiRoute, empresa.toJson());
  }

  Future<HttpResponsse> actualizar(Empresa empresa) async {
    return await actualizarResponse(apiRoute, empresa.toJson(), empresa.id);
  }

  Future<HttpResponsse> delete(Empresa empresa) async {
    return await deleteResponse("$apiRoute/${empresa.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> showPerfil(String id) async {
    return await getResponse('$apiRoute/$id');
  }

  Future<HttpResponsse> updatePassword(
      Map<String, dynamic> data, Empresa empresa) async {
    print(data.toString());
    return await actualizarResponse('$apiRoute/password', data, empresa.id);
  }
}
