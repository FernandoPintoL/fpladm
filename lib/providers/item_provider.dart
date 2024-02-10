import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/app/models/http_response.dart';
import 'package:image_picker/image_picker.dart';
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
  TextEditingController detalleController = TextEditingController();
  TextEditingController precioCostoController = TextEditingController();
  TextEditingController precioVentaController = TextEditingController();

  String titleForm = "REGISTRA TU NUEVO ITEM";
  bool isRegister = true;
  String tittleButtom = "Registrar Item";

  Uint8List? image;
  File? selectedImage;
  XFile? returnImage;

  ItemProvider() {
    cargandoLista("");
  }

  void clearInputs() {
    formKey.currentState?.reset();
    queryController.clear();
    detalleController.clear();
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
    clearInputs();
    titleForm = "REGISTRA NUEVO ITEM";
    tittleButtom = "Registra nuevo item";
    isRegister = true;
    item = Item();
    notifyListeners();
  }

  void register_update_view(BuildContext context) async {
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
    item.detalle = detalleController.text;
    item.precioCosto = double.tryParse(precioCostoController.text.toString())!;
    item.precioVenta = double.tryParse(precioVentaController.text.toString())!;
    item.isHabilitado = true;
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
        clearInputs();
      }
    });
  }

  void openFormUpdate(Item item) {
    detalleController.text = item.detalle;
    precioCostoController.text = item.precioCosto.toString();
    precioVentaController.text = item.precioVenta.toString();
    notifyListeners();
  }

  void eliminando(BuildContext context) async {
    print(item.toString());
    isLoading = true;
    notifyListeners();
    httpResponsse = await controller.delete(item);
    isLoading = false;
    notifyListeners();
    cargandoLista("");
    if (!context.mounted) return;
    DialogMessage.dialog(
        context,
        httpResponsse.success ? DialogType.success : DialogType.error,
        httpResponsse.message.toString(),
        httpResponsse.data.toString(),
        () async {});
  }

  void subirImagenView(BuildContext context) async {
    if (!formKey.currentState!.mounted) return;
    if (formKey.currentState!.validate()) {
      if (!context.mounted) return;
      DialogMessage.dialog(context, DialogType.question,
          "Estas seguro de subir esta imagen?", "", () async {
        uploadImage();
      });
    }
  }

  void uploadImage() async {
    isLoading = true;
    notifyListeners();
    await controller.cargarImage(item.id, selectedImage!).then((value) {
      httpResponsse = value;
      isLoading = false;
      notifyListeners();
    });
  }
}
