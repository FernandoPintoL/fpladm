import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/providers/item_provider.dart';
import 'package:fpladm/view/item/form_register_item.dart';
import 'package:provider/provider.dart';
import '../../app/models/item_model.dart';
import '../components/widget/dialog.dart';
import '../components/widget/image_component.dart';
import '../config/pallet.dart';
import '../page_gestion/card_list.dart';
import 'form_update_item.dart';

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
            title: listado[index].name.toString(),
            subtitle: "${listado[index].precioCosto} BS",
            leading: ImageComponent(
              size: 80,
              imageUrl: listado[index].photoPath.toString(),
            ),
            trailing: IconButton(
              onPressed: () async {
                DialogMessage.dialog(
                    context,
                    DialogType.question,
                    'Eliminar Categoria',
                    'Estas seguro de eliminar ${listado[index].name.toString().toUpperCase()}?',
                    () async {
                  /*context
                          .read<ItemProvider>()
                          .eliminando(context, listado[index]);*/
                });
              },
              icon: const Icon(CupertinoIcons.delete),
              hoverColor: Colors.white,
            ),
            function: () {
              context.read<ItemProvider>().openFormUpdate(listado[index]);
              context.read<ItemProvider>().isRegister = false;
              context.read<ItemProvider>().item = listado[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FormRegisterUpdateItem()),
              );
            },
          );
        });
  }
}
