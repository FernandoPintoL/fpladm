import 'package:flutter/material.dart';

class UpdateView extends StatelessWidget {
  String title;
  Widget formulario;

  UpdateView({super.key, required this.title, required this.formulario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: formulario,
      ),
    );
  }
}
