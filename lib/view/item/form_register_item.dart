import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/view/page_gestion/register/register_view.dart';
import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';
import '../components/metodos/CustomTextFormField.dart';
import '../components/widget/customTextFormField.dart';
import '../components/widget/form_button.dart';
import '../components/widget/loading.dart';
import '../config/pallet.dart';

class FormRegisterUpdateItem extends StatelessWidget {
  FormRegisterUpdateItem({super.key});

  @override
  Widget build(BuildContext context) {
    return RegisterView(
        title: context.read<ItemProvider>().isRegister
            ? "Nuevo Item"
            : "Actualiza el item : ${context.read<ItemProvider>().item.name}",
        function: () {
          context.read<ItemProvider>().clearEditing();
        },
        formulario: context.watch<ItemProvider>().isLoading
            ? Loading(
                text: context.read<ItemProvider>().isRegister
                    ? "Registrando nuevo item..."
                    : "Actualizando : \n${context.read<ItemProvider>().item.name}")
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
                              context
                                  .read<ItemProvider>()
                                  .register_update_view(context);
                            },
                            title: context.read<ItemProvider>().isRegister
                                ? "Registar Item"
                                : "Actualizar item",
                            icon: const Icon(Icons.refresh),
                          ),
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
