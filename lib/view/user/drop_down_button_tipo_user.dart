// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class DropDownButtonSearchTipoUser extends StatefulWidget {
//   const DropDownButtonSearchTipoUser({super.key});
//
//   @override
//   State<DropDownButtonSearchTipoUser> createState() => _DropDownButtonSearchTipoUserState();
// }
//
// class _DropDownButtonSearchTipoUserState extends State<DropDownButtonSearchTipoUser> {
//   TipoUser? seleccionado;
//   final TextEditingController textEditingController = TextEditingController();
//
//   @override
//   void dispose() {
//     textEditingController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<TipoUser>(
//         isExpanded: true,
//         hint: Text(
//           'Selecciona un tipo de usuario',
//           style: TextStyle(
//             fontSize: 14,
//             color: Theme.of(context).hintColor,
//           ),
//         ),
//         items: context.read<UserProvider>().listTipoUser.map((item) => DropdownMenuItem(
//           value: item,
//           child: ListTile(
//             //contentPadding: const EdgeInsets.all(defaultPadding),
//             leading: Text(item.id.toString()),
//             title: Text(
//               item.nombre,
//               style: const TextStyle(
//                 fontSize: 14,
//               ),
//             ),
//             subtitle: Text(item.descripcion)
//           ),
//         )).toList(),
//         value: seleccionado,
//         onChanged: (value) {
//           context.read<UserProvider>().tipoUser = value!;
//           setState(() {
//             seleccionado = value;
//           });
//         },
//         buttonStyleData: const ButtonStyleData(
//           //padding: EdgeInsets.symmetric(horizontal: 16),
//           //height: 40,
//           //width: 200,
//         ),
//         dropdownStyleData: const DropdownStyleData(
//           //maxHeight: 200,
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           //height: 40,
//         ),
//         dropdownSearchData: DropdownSearchData(
//           searchController: textEditingController,
//           searchInnerWidgetHeight: 50,
//           searchInnerWidget: Container(
//             height: 50,
//             padding: const EdgeInsets.only(
//               top: 8,
//               bottom: 4,
//               right: 8,
//               left: 8,
//             ),
//             child: TextFormField(
//               expands: true,
//               maxLines: null,
//               controller: textEditingController,
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 8,
//                 ),
//                 hintText: 'Buscar Categoria...',
//                 hintStyle: const TextStyle(fontSize: 12),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           searchMatchFn: (item, searchValue) {
//             bool isId = item.value!.id.toString().contains(searchValue);
//             bool isNombre = item.value!.nombre.toString().toLowerCase().contains(searchValue.toLowerCase());
//             bool isDescripcion = item.value!.descripcion.toString().toLowerCase().contains(searchValue.toLowerCase());
//             return isId || isNombre || isDescripcion;
//           },
//         ),
//         //This to clear the search value when you close the menu
//         onMenuStateChange: (isOpen) {
//           if (!isOpen) {
//             textEditingController.clear();
//           }
//         },
//       ),
//     );
//   }
// }
