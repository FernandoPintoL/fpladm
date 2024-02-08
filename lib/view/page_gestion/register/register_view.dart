import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  String title;
  Widget formulario;
  Function function;

  RegisterView(
      {super.key,
      required this.title,
      required this.formulario,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
              onPressed: () {
                function();
              },
              icon: const Icon(Icons.delete_outline))
        ],
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: formulario,
      ),
    );
  }
}
