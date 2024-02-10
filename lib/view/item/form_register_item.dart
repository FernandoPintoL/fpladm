import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/view/page_gestion/register/register_view.dart';
import 'package:fpladm/view/upload_image/upload_image.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';
import '../components/widget/customTextFormField.dart';
import '../components/widget/form_button.dart';
import '../components/widget/image_component.dart';
import '../components/widget/loading.dart';
import '../config/pallet.dart';
import '../user/perfil_image/perfil_image.dart';

class FormRegisterUpdateItem extends StatelessWidget {
  const FormRegisterUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterView(
        title: context.read<ItemProvider>().isRegister
            ? "Nuevo Item"
            : "Actualiza el item : ${context.read<ItemProvider>().item.detalle}",
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
                        ImageComponent(
                          size: 80,
                          imageUrl: context
                              .read<ItemProvider>()
                              .item
                              .photoPath
                              .toString(),
                          errorWidget: ClipOval(
                            child: Material(
                              color: Colors.blue,
                              child: InkWell(
                                splashColor: Colors.purple,
                                onTap: () {
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
                                child: const SizedBox(
                                  height: 120,
                                  width: 120,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    size: 70,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                              context
                                  .read<ItemProvider>()
                                  .register_update_view(context);
                            },
                            title: context.read<ItemProvider>().isRegister
                                ? "Registar Item"
                                : "Actualizar item",
                            icon: context.read<ItemProvider>().isRegister
                                ? const Icon(Icons.add_circle_outline)
                                : const Icon(Icons.refresh),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
