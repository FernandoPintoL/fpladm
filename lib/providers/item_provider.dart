import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/app/models/http_response.dart';
import '../app/controller/item_controller.dart';
import '../app/models/item_model.dart';
import '../view/components/widget/dialog.dart';

class ItemProvider extends ChangeNotifier {
  Item item = Item();
  ItemController controller = ItemController();
  HttpResponsse httpResponsse = HttpResponsse();
  List<Item> lista = [];
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController queryController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  TextEditingController precioCostoController = TextEditingController();
  TextEditingController precioVentaController = TextEditingController();

  String titleForm = "REGISTRA TU NUEVO ITEM";
  bool isRegister = true;
  String tittleButtom = "Registrar Item";

  ItemProvider() {
    cargandoLista("");
  }

  void clearEditing() {
    formKey.currentState!.reset();
    queryController.clear();
    nombreController.clear();
    descripcionController.clear();
    precioCostoController.clear();
    precioVentaController.clear();
    notifyListeners();
  }

  void cargandoLista(String query) async {
    isLoading = true;
    notifyListeners();
    httpResponsse = await controller.consultar(query);
    if (httpResponsse.isRequest && httpResponsse.success) {
      lista = Item().parseDynamicToItem(httpResponsse.data);
      notifyListeners();
    }
    isLoading = false;
    notifyListeners();
  }

  void consultando(BuildContext context) async {
    print(queryController.text);
    cargandoLista(queryController.text);
  }

  void openFormularioRegister() {
    //clearInputs();
    titleForm = "REGISTRA NUEVO ITEM";
    tittleButtom = "Registra nuevo item";
    isRegister = true;
    item = Item();
    notifyListeners();
  }

  void register_update_view(BuildContext context) {
    notifyListeners();
    if (!formKey.currentState!.mounted) return;
    if (formKey.currentState!.validate()) {
      if (!context.mounted) return;
      DialogMessage.dialog(
          context,
          DialogType.question,
          isRegister
              ? "Estas Seguro que deseas registrar estos datos?"
              : "Estas Seguro que deseas actualizar estos datos?",
          "", () async {
        formKey.currentState!.save();
        registrando_update(context);
      });
    }
  }

  void cargarDatosItem() {
    item.name = nombreController.text;
    item.descripcion = descripcionController.text;
    item.precioCosto = double.tryParse(precioCostoController.text.toString())!;
    item.precioVenta = double.tryParse(precioVentaController.text.toString())!;
    notifyListeners();
  }

  void registrando_update(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    cargarDatosItem();
    if (isRegister) {
      httpResponsse = await controller.insertar(item);
      if (httpResponsse.success) {
        item = Item.fromJson(httpResponsse.data);
        notifyListeners();
      }
    } else {
      httpResponsse = await controller.actualizar(item);
    }
    isLoading = false;
    notifyListeners();
    if (!context.mounted) return;
    DialogMessage.dialog(
        context,
        httpResponsse.success ? DialogType.success : DialogType.error,
        httpResponsse.message.toString(),
        httpResponsse.data.toString(), () async {
      if (httpResponsse.success) {
        formKey.currentState!.reset();
        cargandoLista("");
        clearEditing();
      }
    });
  }

  void openFormUpdate(Item item) {
    nombreController.text = item.name;
    descripcionController.text = item.descripcion;
    precioCostoController.text = item.precioCosto.toString();
    precioVentaController.text = item.precioVenta.toString();
    notifyListeners();
  }
}
