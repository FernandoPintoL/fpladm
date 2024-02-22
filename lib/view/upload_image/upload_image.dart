import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/providers/item_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
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
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.read<ItemProvider>().item.detalle,
            style: GoogleFonts.lobster()),
        backgroundColor: Colors.transparent,
      ),
      body: context.watch<ItemProvider>().isLoading
          ? Loading(text: "Cargando Imagen...")
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: defaultPadding),
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "DATOS",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'COD: ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text: context
                                        .read<ItemProvider>()
                                        .item
                                        .id
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'PRECIO COSTO: ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "${context.read<ItemProvider>().item.precioCosto.toString()} Bs",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'PRECIO VENTA: ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "${context.read<ItemProvider>().item.precioVenta.toString()} Bs",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w200)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding,
                        vertical: defaultPadding + 40),
                    child: Stack(
                      children: [
                        if (context.watch<ItemProvider>().imageList != null &&
                            !kIsWeb)
                          ClipRRect(
                            child: Image.memory(
                              fit: BoxFit.cover,
                              context.read<ItemProvider>().imageList!,
                            ),
                          )
                        else
                          ImageComponent(
                              imageUrl:
                                  context.watch<ItemProvider>().item.photoPath,
                              errorWidget: ClipOval(
                                child: Material(
                                  color: Colors.blue,
                                  child: InkWell(
                                    splashColor: Colors.redAccent,
                                    onTap: () {
                                      showImagePickerOption(context);
                                    },
                                    child: const SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 90,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              function: () {
                                if (context.read<ItemProvider>().isRegister)
                                  return;
                                Navigator.push(
                                    context,
                                    PageTransition(
                                      child: UploadImage(
                                        name: context
                                            .read<ItemProvider>()
                                            .item
                                            .detalle,
                                        photoPath: context
                                            .read<ItemProvider>()
                                            .item
                                            .photoPath,
                                        id: context
                                            .read<ItemProvider>()
                                            .item
                                            .id,
                                        subirImage: () {},
                                      ),
                                      type: PageTransitionType.scale,
                                      alignment: Alignment.bottomCenter,
                                      duration: const Duration(seconds: 1),
                                    ));
                              },
                              size: 120),
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
                      onPressed: () async {
                        context.read<ItemProvider>().subirImagenView(context);
                      },
                      child: const Text("Subir Imagen"))
                ],
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
    context.read<ItemProvider>().imageXFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (context.read<ItemProvider>().imageXFile == null) return;
    setState(() {
      context.read<ItemProvider>().fileImage =
          File(context.read<ItemProvider>().imageXFile!.path);
      context.read<ItemProvider>().imageList =
          File(context.read<ItemProvider>().imageXFile!.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  void _pickImageFormCamera() async {
    context.read<ItemProvider>().imageXFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (context.read<ItemProvider>().imageXFile == null) return;
    /*setState(() {

    });*/
    context.read<ItemProvider>().fileImage =
        File(context.read<ItemProvider>().imageXFile!.path);
    context.read<ItemProvider>().imageList =
        File(context.read<ItemProvider>().imageXFile!.path).readAsBytesSync();
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
