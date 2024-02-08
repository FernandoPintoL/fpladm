import 'package:flutter/material.dart';
import '../dashboard/tablero.dart';
import '../dashboard/tap_info_list.dart';

class HomeDesktop extends StatelessWidget {
  const HomeDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Tablero(title: "Inicio", listTaps: demoMyTaps),
    );
  }
}
