import 'package:flutter/material.dart';

class FormButtom extends StatelessWidget {
  Function ejecutar;
  String title;
  Icon icon;

  FormButtom(
      {super.key,
      required this.ejecutar,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green)),
        onPressed: () {
          ejecutar();
        },
        child: RichText(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          text: TextSpan(
            children: [
              TextSpan(
                style: const TextStyle(fontSize: 16),
                text: title,
              ),
              WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: icon,
              ),
            ],
          ),
        ));
  }
}
