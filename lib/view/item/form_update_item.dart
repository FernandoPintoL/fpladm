import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/providers/item_provider.dart';
import 'package:fpladm/view/page_gestion/update/update_view.dart';
import 'package:provider/provider.dart';
import '../components/metodos/CustomTextFormField.dart';
import '../components/widget/customTextFormField.dart';
import '../components/widget/form_button.dart';
import '../components/widget/loading.dart';
import '../config/pallet.dart';

class UpdateItem extends StatelessWidget {
  const UpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return UpdateView(
        title: "Nuevo Item",
        formulario: context.watch<ItemProvider>().isLoading
            ? Loading(text: "Registrando nuevo item...")
            : Form(
                key: context.watch<ItemProvider>().formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 22.0, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //NOMBRE
                        CustomFormField(
                          textController:
                              context.watch<ItemProvider>().nombreController,
                          typeText: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          hintText: "producto ",
                          label: const Text("Nombre: "),
                          helperText: context
                              .watch<ItemProvider>()
                              .item
                              .nameError
                              .toString(),
                          icon: const Icon(CupertinoIcons.person_alt_circle),
                          textStyle: context
                                  .watch<ItemProvider>()
                                  .item
                                  .nameError
                                  .toString()
                                  .isEmpty
                              ? const TextStyle(color: Colors.white)
                              : const TextStyle(color: Colors.redAccent),
                          validator: (value) =>
                              CustomText().isValidName(value!),
                          onChanged: (value) =>
                              CustomText().isValidName(value!),
                        ),
                        //DESCRIPCION
                        CustomFormField(
                          textController: context
                              .watch<ItemProvider>()
                              .descripcionController,
                          typeText: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                          hintText: "Describe ",
                          label: const Text("Descripcion: "),
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
                              /*context
                                  .read<ItemProvider>()
                                  .formKey
                                  .currentState!
                                  .save();
                              context
                                  .read<ItemProvider>()
                                  .registerView(context);*/
                            },
                            title: "Registar Item",
                            icon: const Icon(Icons.refresh),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
