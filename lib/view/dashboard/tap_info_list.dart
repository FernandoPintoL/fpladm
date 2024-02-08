import 'package:flutter/material.dart';
import '../../app/models/tap_info.dart';
import '../config/pallet.dart';

List<TapInfo> demoMyTaps = [
  TapInfo(
      title: "Gestion de Usuarios",
      numOfFiles: 1328,
      svgSrc: "assets/icons/store-solid.svg",
      totalStorage: "1.9GB",
      color: primaryColor,
      percentage: 35,
      route: '/userview'),
  TapInfo(
      title: "Inventario / Catálogo",
      numOfFiles: 1328,
      svgSrc: "assets/icons/google_drive.svg",
      totalStorage: "2.9GB",
      color: const Color(0xFFFFA113),
      percentage: 35,
      route: '/itemview')
];

// List<TapInfo> gestionUsuario = [
//   TapInfo(
//       title: "Usuarios",
//       numOfFiles: 1328,
//       svgSrc: "assets/icons/google_drive.svg",
//       totalStorage: "2.9GB",
//       color: const Color(0xFFFFA113),
//       percentage: 35,
//       route: '/userview'
//   ),
//   TapInfo(
//     title: "Ajustes",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/store-solid.svg",
//     totalStorage: "1.9GB",
//     color: primaryColor,
//     percentage: 35,
//     route: '/settings'
//   ),
//   TapInfo(
//     title: "Roles",
//     numOfFiles: 1328,
//     svgSrc: "assets/icons/one_drive.svg",
//     totalStorage: "1GB",
//     color: const Color(0xFFA4CDFF),
//     percentage: 10,
//       route: '/roleview'
//   ),
//   TapInfo(
//     title: "Permisos",
//     numOfFiles: 5328,
//     svgSrc: "assets/icons/drop_box.svg",
//     totalStorage: "7.3GB",
//     color: const Color(0xFF007EE5),
//     percentage: 78,
//       route: '/categoriaUsuario'
//   ),
// ];
