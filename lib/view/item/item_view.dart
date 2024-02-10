import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/view/item/form_register_item.dart';
import 'package:fpladm/view/item/item_list.dart';
import 'package:provider/provider.dart';
import '../../providers/item_provider.dart';
import '../page_gestion/page_gestion.dart';
import '../page_gestion/register/register_view.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('GESTION DE ITEM'),
      ),
      body: SafeArea(
        child: PageGestion(
            queryController: context.watch<ItemProvider>().queryController,
            httpResponsse: context.watch<ItemProvider>().httpResponsse,
            isLoading: context.watch<ItemProvider>().isLoading,
            functionBuscar: () {
              context.read<ItemProvider>().consultando(context);
            },
            registrarNuevo: () {
              context.read<ItemProvider>().openFormularioRegister();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FormRegisterUpdateItem()),
              );
            },
            refrescarPagina: () {
              context.read<ItemProvider>().cargandoLista("");
            },
            isListEmpty: context.watch<ItemProvider>().lista.isEmpty,
            listado: context.watch<ItemProvider>().lista,
            //listadoWidget: UsersList(listado: context.watch<ItemProvider>().lista),
            listadoWidget:
                ItemList(listado: context.watch<ItemProvider>().lista)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ItemProvider>().openFormularioRegister();
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const FormRegisterUpdateItem()),
          );
        },
        tooltip: "Registra un nuevo item",
        child: const Icon(CupertinoIcons.add_circled),
      ),
    );
  }
}
