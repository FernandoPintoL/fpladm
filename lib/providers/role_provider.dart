import 'package:flutter/widgets.dart';
import '../app/controller/role_controller.dart';
import '../app/models/http_response.dart';
import '../app/models/rol_model.dart';

class RoleProvider extends ChangeNotifier {
  Rol rol = Rol();
  RoleController controller = RoleController();
  List<Rol> lista = [];
  HttpResponsse httpResponsse = HttpResponsse();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController guardNameController = TextEditingController();

  bool isLoading = true;

  RoleProvider() {
    cargandoLista("");
  }

  void cargandoLista(String query) async {
    isLoading = true;
    notifyListeners();
    httpResponsse = await controller.consultar(query);
    isLoading = false;
    notifyListeners();
    if (httpResponsse.isRequest && httpResponsse.success) {
      lista = Rol().parseRol(httpResponsse.data);
      notifyListeners();
    }
  }
}
