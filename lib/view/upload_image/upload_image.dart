import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/providers/item_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../components/widget/dialog.dart';
import '../components/widget/image_component.dart';
import '../components/widget/loading.dart';
import '../config/pallet.dart';

class UploadImage extends StatefulWidget {
  String name;
  String photoPath;
  int id;
  Function subirImage;

  UploadImage(
      {super.key,
      required this.name,
      required this.photoPath,
      required this.id,
      required this.subirImage});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  Uint8List? image;
  File? selectedImage;
  XFile? returnImage;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<ItemProvider>().item.detalle),
      ),
      body: context.watch<ItemProvider>().isLoading
          ? Loading(text: "Cargando Imagen...")
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Stack(
                        children: [
                          if (image != null && !kIsWeb)
                            Column(
                              children: [
                                const Text("memori"),
                                ClipRRect(
                                  child: Image.memory(
                                    fit: BoxFit.cover,
                                    image!,
                                  ),
                                ),
                              ],
                            )
                          else
                            Column(
                              children: [
                                const Text("component"),
                                ImageComponent(
                                    imageUrl: widget.photoPath,
                                    errorWidget: const CircleAvatar(
                                        child:
                                            Icon(Icons.person_outline_rounded)),
                                    size:
                                        MediaQuery.of(context).size.width > 1000
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                150),
                              ],
                            ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: IconButton(
                                  style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.green)),
                                  onPressed: () {
                                    showImagePickerOption(context);
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.white,
                                  ))),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        onPressed: () {
                          DialogMessage.dialog(
                              context,
                              DialogType.question,
                              "¿Estas seguro de subir esta imagen?",
                              "", () async {
                            //subirImagen();
                            widget.subirImage();
                          });
                        },
                        child: const Text("Subir Imagen"))
                  ],
                ),
              ),
            ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 6,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        _pickImageFormGaleria();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50,
                            ),
                            Expanded(child: Text("Galeria"))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFormCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                            ),
                            Expanded(child: Text("Camara"))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void _pickImageFormGaleria() async {
    returnImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage!.path);
      image = File(returnImage!.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  void _pickImageFormCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

/*void subirImagen() async {
    HttpResponsse httpResponsse = HttpResponsse();
    setState(() {
      isLoading = true;
    });
    if (widget.isUser) {
      await userController.cargarImage(widget.id, selectedImage!).then((value) {
        httpResponsse = value;
        setState(() {
          isLoading = false;
        });
      });
    } else {
      //cargar imagen del articulo
    }
  }*/
}
