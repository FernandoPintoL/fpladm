import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  String title;
  Widget formulario;
  Function function;
  late List<Widget> actions;

  RegisterView(
      {super.key,
      required this.title,
      required this.formulario,
      required this.function,
      required this.actions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: actions,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: formulario,
      ),
    );
  }
}
