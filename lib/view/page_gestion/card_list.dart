import 'package:flutter/material.dart';
import '../config/pallet.dart';

class CardList extends StatelessWidget {
  String title;
  String subtitle;
  Widget trailing;
  Widget leading;
  Function function;

  CardList(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.trailing,
      required this.leading,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: leading,
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: trailing,
          onTap: () {
            function();
          },
        ),
      ),
    );
  }
}
