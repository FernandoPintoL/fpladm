// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:solucioneslp/controller/tipo_user_controller.dart';
// import 'package:solucioneslp/models/tipo_user_model.dart';
// import 'package:solucioneslp/models/http_response.dart';
// import 'package:solucioneslp/vista/components/Widget/dialog.dart';
// import 'package:solucioneslp/vista/components/Widget/loading.dart';
// import 'package:solucioneslp/vista/configuracion/current_page.dart';
// import 'package:solucioneslp/vista/tipo_user/form_register_upate.dart';
// import 'package:solucioneslp/vista/tipo_user/list_builder_view.dart';
//
// class TipoUserProvider extends ChangeNotifier{
//   Widget container = const Center(child: Text('Iniciando Pagina...'));
//   bool isLoading = true;
//   TipoUserController controller = TipoUserController();
//   TipoUser tipoUser = TipoUser();
//   List<TipoUser> lista = [];
//
//   var currentPage = Secciones.listado;
//   String titleForm = "REGISTRA TU NUEVA CATEGORIA";
//   bool isRegister = true;
//   String tittleButtom = "Registrar Categoria";
//
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   TextEditingController nombreController = TextEditingController();
//   TextEditingController descripcionController = TextEditingController();
//   TextEditingController queryController = TextEditingController();
//
//   TipoUserProvider(){
//     cargandoLista("");
//   }
//
//   void cargandoLista(String query) async {
//     isLoading = true;
//     container = const Loading();
//     notifyListeners();
//     lista = await controller.listar(query);
//     currentPage = Secciones.listado;
//     isLoading = false;
//     container = const ListaBuilderView();
//     notifyListeners();
//   }
//
//   void changePage(int id) async{
//     if(id == 1){
//       //cargar pagina de listado
//       container = const Loading();
//       notifyListeners();
//       lista = await controller.listar('');
//       currentPage = Secciones.listado;
//       container = const ListaBuilderView();
//       notifyListeners();
//     }else if(id == 2){
//       nombreController.clear();
//       descripcionController.clear();
//       isRegister = true;
//       titleForm = "REGISTRA TU NUEVA CATEGORIA";
//       tittleButtom = "Registrar Categoria";
//       currentPage = Secciones.register;
//       container = const FormRegisterUpdate();
//       notifyListeners();
//     }
//   }
//
//   void openFormularioUpdate(TipoUser categoriaUsuario){
//     titleForm = "ACTUALIZA LA CATEGORIA";
//     tittleButtom = "Actualiza tu categoria";
//     isRegister = false;
//     this.tipoUser = categoriaUsuario;
//     nombreController.text = categoriaUsuario.nombre;
//     descripcionController.text = categoriaUsuario.descripcion;
//     container = const FormRegisterUpdate();
//     currentPage = Secciones.register;
//     notifyListeners();
//   }
//
//   void registrando(BuildContext context) async {
//       tipoUser.nombre = nombreController.text;
//       tipoUser.descripcion = descripcionController.text;
//       HttpResponsse httpResponsse = HttpResponsse();
//       if(isRegister){
//         httpResponsse = await controller.insertar(tipoUser);
//       }else{
//         httpResponsse = await controller.actualizar(tipoUser);
//       }
//       //errores al retornar
//       if(httpResponsse.isRequest && !httpResponsse.success){
//         tipoUser.nombreError = httpResponsse.data['nombre'];
//         notifyListeners();
//       }
//
//       if (!context.mounted) return;
//       DialogMessage.dialog(context,
//           httpResponsse.success ? DialogType.success : DialogType.error,
//           httpResponsse.message,
//           httpResponsse.data.toString(),
//               () async {
//             if(httpResponsse.success){
//               formKey.currentState!.reset();
//               nombreController.clear();
//               descripcionController.clear();
//               tipoUser.nombre = "";
//               tipoUser.descripcion = "";
//               tipoUser.nombreError = "";
//               lista = await controller.listar("");
//               notifyListeners();
//             }
//           });
//   }
//
//   void eliminando(BuildContext context, int index) async {
//     HttpResponsse httpResponsse = await controller.delete(lista[index]);
//     if(!context.mounted)return;
//     DialogMessage.dialog(context,
//         httpResponsse.success ? DialogType.success : DialogType.error,
//         httpResponsse.message,
//         httpResponsse.data.toString(),
//             (){}
//     );
//
//     lista = await controller.listar('');
//
//     currentPage = Secciones.listado;
//     isLoading = false;
//     container = const ListaBuilderView();
//     notifyListeners();
//   }
//
//   void consultando() async {
//     print(queryController.text);
//     isLoading = true;
//     container = const Loading();
//     notifyListeners();
//     lista = await controller.listar(queryController.text);
//     currentPage = Secciones.listado;
//     isLoading = false;
//     container = const ListaBuilderView();
//     notifyListeners();
//   }
// }