import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/view/page_gestion/register/register_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';
import '../components/widget/customTextFormField.dart';
import '../components/widget/dialog.dart';
import '../components/widget/form_button.dart';
import '../components/widget/image_component.dart';
import '../components/widget/loading.dart';
import '../config/pallet.dart';

class FormRegisterUpdateItem extends StatelessWidget {
  const FormRegisterUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterView(
        title: context.read<ItemProvider>().isRegister
            ? "Nuevo Item"
            : "Actualización COD : ${context.read<ItemProvider>().item.id.toString().toUpperCase()}",
        function: () {},
        actions: [
          IconButton(
              tooltip: "Limpiar Formulario",
              onPressed: () {
                context.read<ItemProvider>().clearInputs();
              },
              icon: const Icon(Icons.delete_outline))
        ],
        formulario: context.watch<ItemProvider>().isLoading
            ? Loading(
                text: context.read<ItemProvider>().isRegister
                    ? "Registrando nuevo item..."
                    : "Actualizando : \n${context.read<ItemProvider>().item.detalle}")
            : Form(
                key: context.watch<ItemProvider>().formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (!context.read<ItemProvider>().isRegister)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18.0),
                            child: Text(
                                context
                                    .read<ItemProvider>()
                                    .item
                                    .detalle
                                    .toUpperCase(),
                                style: GoogleFonts.workSans(
                                    fontSize: 25, fontWeight: FontWeight.w400)),
                          ),
                        //IMAGEN
                        Stack(
                          children: [
                            //VISTA PARA EL MOBILE
                            if (!kIsWeb &&
                                context.watch<ItemProvider>().imageXFile !=
                                    null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                    width:
                                        MediaQuery.of(context).size.width - 140,
                                    height:
                                        MediaQuery.of(context).size.width - 140,
                                    fit: BoxFit.fill,
                                    context.watch<ItemProvider>().fileImage!),
                              )
                            //VISTA PARA WEB
                            else if (kIsWeb &&
                                context.watch<ItemProvider>().platformFile !=
                                    null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.memory(
                                  /*Uint8List.fromList(context
                                      .watch<ItemProvider>()
                                      .platformFile!
                                      .bytes!),*/
                                  context.watch<ItemProvider>().imageList!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            else
                              ImageComponent(
                                size: 120,
                                imageUrl: context
                                    .read<ItemProvider>()
                                    .item
                                    .photoPath
                                    .toString(),
                                errorWidget: const CircleAvatar(
                                  radius: 90,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 120,
                                  ),
                                ),
                                function: () {
                                  showImagePickerOption(context);
                                },
                              ),
                            if (!context.watch<ItemProvider>().isRegister)
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.green,
                                  child: IconButton(
                                      splashColor: Colors.amberAccent,
                                      onPressed: () async {
                                        showImagePickerOption(context);
                                      },
                                      iconSize: 35,
                                      icon: const Icon(
                                          Icons.camera_alt_outlined)),
                                ),
                              )
                          ],
                        ),
                        const SizedBox(height: 50),
                        //DETALLE
                        CustomFormField(
                          textController:
                              context.watch<ItemProvider>().detalleController,
                          typeText: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          hintText: "Detalle ",
                          label: const Text("Detalle: "),
                          helperText: "",
                          icon: const Icon(CupertinoIcons.text_bubble_fill),
                          textStyle: const TextStyle(color: Colors.white),
                          validator: null,
                          onChanged: null,
                        ),
                        //PRECIOS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //PRECIO COSTO
                            Expanded(
                              child: CustomFormField(
                                textController: context
                                    .watch<ItemProvider>()
                                    .precioCostoController,
                                typeText: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                hintText: "10",
                                label: const Text("Precio Costo: "),
                                helperText: context
                                    .watch<ItemProvider>()
                                    .item
                                    .precioCostoError
                                    .toString(),
                                icon:
                                    const Icon(Icons.monetization_on_outlined),
                                textStyle: context
                                        .watch<ItemProvider>()
                                        .item
                                        .precioCostoError
                                        .toString()
                                        .isEmpty
                                    ? const TextStyle(color: Colors.white)
                                    : const TextStyle(color: Colors.redAccent),
                                validator: null,
                                onChanged: null,
                              ),
                            ),
                            const SizedBox(width: 25),
                            //PRECIO COSTO
                            Expanded(
                              child: CustomFormField(
                                textController: context
                                    .watch<ItemProvider>()
                                    .precioVentaController,
                                typeText: const TextInputType.numberWithOptions(
                                    signed: false, decimal: true),
                                textInputAction: TextInputAction.next,
                                hintText: "10",
                                label: const Text("Precio Venta: "),
                                helperText: context
                                    .watch<ItemProvider>()
                                    .item
                                    .precioVentaError
                                    .toString(),
                                icon:
                                    const Icon(Icons.monetization_on_outlined),
                                textStyle: context
                                        .watch<ItemProvider>()
                                        .item
                                        .precioVentaError
                                        .toString()
                                        .isEmpty
                                    ? const TextStyle(color: Colors.white)
                                    : const TextStyle(color: Colors.redAccent),
                                validator: null,
                                onChanged: null,
                              ),
                            ),
                          ],
                        ),
                        //BOTON
                        Padding(
                          padding: const EdgeInsets.only(top: defaultPadding),
                          child: FormButtom(
                            ejecutar: () {
                              if (context
                                  .read<ItemProvider>()
                                  .formKey
                                  .currentState!
                                  .validate()) {}
                              context
                                  .read<ItemProvider>()
                                  .formKey
                                  .currentState!
                                  .save();
                              DialogMessage.dialog(
                                  context,
                                  DialogType.question,
                                  context.read<ItemProvider>().isRegister
                                      ? "Estas Seguro que deseas registrar estos datos?"
                                      : "Estas Seguro que deseas actualizar estos datos?",
                                  "", () async {
                                context
                                    .read<ItemProvider>()
                                    .registrando_update(context);
                              });
                            },
                            title: context.read<ItemProvider>().isRegister
                                ? "Registar Item"
                                : "Actualizar item",
                            icon: context.read<ItemProvider>().isRegister
                                ? const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.0),
                                    child: Icon(Icons.add_circle_outline),
                                  )
                                : const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.0),
                                    child: Icon(Icons.refresh),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.lightGreen,
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () async {
                        //_pickImageFormGaleria();
                        if (kIsWeb) {
                          print("estamos en web");
                          context
                              .read<ItemProvider>()
                              .pickImageGaleryWeb(context);
                        } else {
                          print("estamos en mobile");
                          context.read<ItemProvider>().pickImageGalery(context);
                        }
                      },
                      child: const SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                      splashColor: Colors.lightGreen,
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onTap: () {
                        //_pickImageFormCamera();
                        context.read<ItemProvider>().pickImageCamera(context);
                      },
                      child: const SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
}
