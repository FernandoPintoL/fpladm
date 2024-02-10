import 'dart:io';
import '../models/http_response.dart';
import '../models/item_model.dart';
import 'request_controller.dart';

class ItemController with RequestController {
  List<Item> lista = [];
  String apiRoute = 'items';

  Future<HttpResponsse> insertar(Item item) async {
    print(item.toString());
    return await insertResponse(apiRoute, item.toJson());
  }

  Future<HttpResponsse> actualizar(Item item) async {
    return await actualizarResponse(apiRoute, item.toJson(), item.id);
  }

  Future<HttpResponsse> delete(Item item) async {
    return await deleteResponse("$apiRoute/${item.id.toString()}");
  }

  Future<HttpResponsse> consultar(String query) async {
    return await consulta('$apiRoute/consultar', {'query': query});
  }

  Future<HttpResponsse> cargarImage(int id, File file) async {
    return await subirfile('$apiRoute/subirimage', file, id);
  }
}
