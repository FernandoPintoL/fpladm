import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/app/models/user_model.dart';
import 'package:fpladm/view/components/widget/search_text_field.dart';
import 'package:fpladm/view/user/list_user/users_list.dart';
import '../../app/models/http_response.dart';
import '../components/widget/loading.dart';
import 'page_response.dart';

class PageGestion extends StatelessWidget {
  bool isLoading;
  HttpResponsse httpResponsse;
  TextEditingController queryController;
  Function functionBuscar;
  Function registrarNuevo;
  Function refrescarPagina;
  bool isListEmpty;
  List listado;
  Widget listadoWidget;

  PageGestion(
      {super.key,
      required this.isLoading,
      required this.httpResponsse,
      required this.queryController,
      required this.functionBuscar,
      required this.registrarNuevo,
      required this.refrescarPagina,
      required this.isListEmpty,
      required this.listado,
      required this.listadoWidget});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BuscadorTextField(
            queryController: queryController,
            ejecutar: () {
              functionBuscar();
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Busqueda encontrada con : ${listado.length.toString()}"),
              CupertinoButton(
                  child: const Row(
                    children: [Text("Recargar Pagina"), Icon(Icons.refresh)],
                  ),
                  onPressed: () {
                    functionBuscar();
                  })
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(color: Colors.white),
        ),
        if (isLoading)
          Loading(text: "Cargando Pagina...")
        else if (!httpResponsse.isRequest)
          PageResponse(httpResponsse: httpResponsse)
        else if (listado.isEmpty)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                queryController.text.isNotEmpty
                    ? Text(
                        "No se encuentran datos registrados con: ${queryController.text}")
                    : const Text("No se encuentran datos registrados"),
                queryController.text.isEmpty
                    ? CupertinoButton(
                        onPressed: () {
                          registrarNuevo();
                        },
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("¿Deseas registrar nuevos datos?"),
                              Icon(Icons.supervised_user_circle_outlined)
                            ],
                          ),
                        ))
                    : CupertinoButton(
                        onPressed: () {
                          //Provider.of<UserProvider>(context, listen: false).changePage(2);
                          //cargandoLista("");
                          refrescarPagina();
                        },
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Recargar Pagina"),
                              Icon(Icons.refresh)
                            ],
                          ),
                        ))
              ],
            ),
          )
        else
          Expanded(
            child: listadoWidget,
            //child: UsersList(listado: listado),
          )
      ],
    );
  }
}
