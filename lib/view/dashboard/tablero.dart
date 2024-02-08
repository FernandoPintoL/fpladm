import 'package:flutter/material.dart';
import '../../app/models/tap_info.dart';
import '../config/pallet.dart';
import 'header.dart';
import 'tapMenuDetalles.dart';

class Tablero extends StatelessWidget {
  String title;
  List<TapInfo> listTaps;
  Tablero({required this.title, required this.listTaps, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(title: title),
              const SizedBox(height: defaultPadding),
              TapMenuDetalles(listTaps: listTaps),
            ],
          ),
        )
    );
  }
}

