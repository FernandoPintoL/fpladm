import 'package:flutter/material.dart';
class TextDescriptivo extends StatelessWidget {
  TextDescriptivo({
    required this.title,
    required this.subtitle,
    super.key
  });
  String title;
  String subtitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: RichText(
        overflow: TextOverflow.fade,
        maxLines: 2,
        softWrap: false,
        text: TextSpan(
          text: title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white70),
          children: <TextSpan>[
            TextSpan(text: subtitle, style: const TextStyle()),
          ],
        ),
      ),
    );
  }
}
