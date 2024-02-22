import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/providers/item_provider.dart';
import 'package:fpladm/view/item/form_register_item.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../app/models/item_model.dart';
import '../components/widget/dialog.dart';
import '../components/widget/image_component.dart';
import '../config/pallet.dart';
import '../page_gestion/card_list.dart';
import '../upload_image/upload_image.dart';

class ItemList extends StatelessWidget {
  List<Item> listado;

  ItemList({super.key, required this.listado});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(defaultPadding),
        itemCount: listado.length,
        itemBuilder: (BuildContext context, int index) {
          return CardList(
            title: listado[index].detalle.toString(),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("COD: ${listado[index].id.toString()}"),
                Text("${listado[index].precioCosto} BS"),
                Text(
                  listado[index].isHabilitado ? "Habilitado" : "Desahabilitado",
                  style: TextStyle(
                      color: listado[index].isHabilitado
                          ? Colors.green
                          : Colors.redAccent),
                )
              ],
            ),
            leading: ImageComponent(
              size: 30,
              imageUrl: listado[index].photoPath.toString(),
              errorWidget:
                  const CircleAvatar(child: Icon(Icons.warning_amber_sharp)),
              function: () {},
            ),
            trailing: IconButton(
              onPressed: () async {
                String habilitar = listado[index].isHabilitado
                    ? "Desahabilitar Item"
                    : "Habilitar Item";
                String contexto =
                    "$habilitar : ${listado[index].detalle.toString().toUpperCase()}";
                DialogMessage.dialog(
                    context, DialogType.question, habilitar, contexto,
                    () async {
                  context.read<ItemProvider>().item = listado[index];
                  context.read<ItemProvider>().eliminando(context);
                });
              },
              icon: const Icon(CupertinoIcons.delete),
              hoverColor: Colors.white,
            ),
            function: () {
              context.read<ItemProvider>().openFormUpdate(listado[index]);
              Navigator.push(
                  context,
                  PageTransition(
                    child: const FormRegisterUpdateItem(),
                    type: PageTransitionType.scale,
                    alignment: Alignment.centerLeft,
                    duration: const Duration(seconds: 1),
                  ));
            },
          );
        });
  }
}
