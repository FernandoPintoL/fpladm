import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/app/models/http_response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  bool isRegister = true;

  ImagePicker picker = ImagePicker();
  Uint8List? imageList;
  File? fileImage;
  XFile? imageXFile;
  PlatformFile? platformFile;

  ItemProvider() {
    cargandoLista("");
  }

  void clearInputs() {
    formKey.currentState?.reset();
    queryController.clear();
    detalleController.clear();
    precioCostoController.clear();
    precioVentaController.clear();
    imageList = null;
    fileImage = null;
    imageXFile = null;
    platformFile = null;
    isLoading = false;
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
    isRegister = true;
    item = Item();
    notifyListeners();
  }

  void cargarDatosItem() {
    httpResponsse = HttpResponsse();
    item.detalle = detalleController.text;
    item.precioCosto = double.tryParse(precioCostoController.text.toString())!;
    item.precioVenta = double.tryParse(precioVentaController.text.toString())!;
    item.isHabilitado = true;
    notifyListeners();
  }

  void openFormUpdate(Item item) {
    imageList = null;
    fileImage = null;
    imageXFile = null;
    platformFile = null;
    this.item = item;
    isRegister = false;
    detalleController.text = item.detalle;
    precioCostoController.text = item.precioCosto.toString();
    precioVentaController.text = item.precioVenta.toString();
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

  void registrando_update(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      cargarDatosItem();
      if (isRegister) {
        httpResponsse = await controller.insertar(item);
        if (httpResponsse.success) {
          item = Item.fromJson(httpResponsse.data);
        }
        if (!context.mounted) return;
        DialogMessage.dialog(
            context,
            httpResponsse.success ? DialogType.success : DialogType.error,
            httpResponsse.message.toString(),
            httpResponsse.data.toString(), () async {
          if (httpResponsse.success) {
            clearInputs();
          }
        });
      } else {
        if (!context.mounted) return;
        if (kIsWeb) {
          print("enviando salida web");
          await controller
              .subirfileUint8list("items/uploadimage", imageList!, item.id)
              .then((value) {
            print("terminar");
          });
        } else {
          await controller.actualizarTodo(item, fileImage!).whenComplete(() {
            print("salimos de la llamada 1");
            DialogMessage.dialog(
                context,
                httpResponsse.success ? DialogType.success : DialogType.error,
                httpResponsse.message.toString(),
                httpResponsse.data.toString(), () async {
              if (httpResponsse.success) {
                clearInputs();
              }
            });
          }).then((value) async {
            httpResponsse = value;
          });
        }
      }
      isLoading = false;
      cargandoLista("");
      print(httpResponsse.toString());
      notifyListeners();
      //if (!context.mounted) return;

      /*DialogMessage.dialog(
          context,
          httpResponsse.success ? DialogType.success : DialogType.error,
          httpResponsse.message.toString(),
          httpResponsse.data.toString(), () async {
        if (httpResponsse.success) {
          cargandoLista("");
          clearInputs();
        }
      });*/
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
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
    httpResponsse = HttpResponsse();
    notifyListeners();
    if (!context.mounted) return;
    DialogMessage.dialog(
        context, DialogType.question, "Estas seguro de subir esta imagen?", "",
        () async {
      uploadImage(context);
    });
  }

  void uploadImage(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await controller
        .sendDioFile(imageList!, "items/uploadimage", item.id)
        .then((value) {
      isLoading = false;
      notifyListeners();
    });
  }

  void pickImageGalery(BuildContext context) async {
    try {
      imageXFile = await picker.pickImage(source: ImageSource.gallery);
      if (imageXFile == null) {
        imageXFile = null;
        fileImage = null;
        notifyListeners();
        if (!context.mounted) return;
        Navigator.of(context).pop();
        DialogMessage.dialog(context, DialogType.info,
            "Ninguna imagen fue seleccionada", "", () {});
        return;
      } else {
        fileImage = File(imageXFile!.path);
        imageList = File(imageXFile!.path).readAsBytesSync();
        notifyListeners();
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void pickImageGaleryWeb(BuildContext context) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result == null) {
        platformFile = null;
        notifyListeners();
        if (!context.mounted) return;
        Navigator.of(context).pop();
        DialogMessage.dialog(
            context, DialogType.info, "Ninguna imagen fue tomada", "", () {});
        return;
      } else {
        platformFile = result.files.first;
        imageList = platformFile!.bytes!;
        notifyListeners();
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void pickImageCamera(BuildContext context) async {
    try {
      imageXFile = await picker.pickImage(source: ImageSource.camera);
      if (imageXFile == null) {
        imageXFile = null;
        fileImage = null;
        notifyListeners();
        if (!context.mounted) return;
        Navigator.of(context).pop();
        DialogMessage.dialog(
            context, DialogType.info, "Ninguna imagen fue tomada", "", () {});
        return;
      } else {
        fileImage = File(imageXFile!.path);
        imageList = File(imageXFile!.path).readAsBytesSync();
        notifyListeners();
        if (!context.mounted) return;
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}
