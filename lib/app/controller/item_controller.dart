import 'dart:io';
import 'package:get/get.dart';

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

  Future<HttpResponsse> actualizarTodo(Item item, File file) async {
    HttpResponsse responsse = HttpResponsse();
    await actualizar(item).then((value) async {
      responsse = value;
      if (value.success && file.path.isNotEmpty) {
        await uploadimagefile(item.id, file)
            .then((value) => responsse = value)
            .whenComplete(() => print("imagenes"));
      }
    }).whenComplete(() => print("impresion de datos"));
    return responsse;
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

  Future<HttpResponsse> uploadimagefile(int id, File file) async {
    return await uploadImage('$apiRoute/uploadimage', file, id);
  }
}
