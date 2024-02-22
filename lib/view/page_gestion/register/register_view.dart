import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        title: Text(title.toUpperCase().toString(),
            style: GoogleFonts.albertSans(
                fontSize: 22, fontWeight: FontWeight.w100)),
        actions: actions,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: formulario,
      ),
    );
  }
}
