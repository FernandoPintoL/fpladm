import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuscadorTextField extends StatelessWidget {
  TextEditingController queryController;
  Function ejecutar;

  BuscadorTextField(
      {super.key, required this.queryController, required this.ejecutar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: queryController,
        //controller: context.watch<UserProvider>().queryController,
        onChanged: (value) {
          if (value.isNotEmpty) {
            //context.read<UserProvider>().consultando(context);
            ejecutar();
          }
        },
        decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 5.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            suffix: IconButton(
                onPressed: () {
                  //context.read<UserProvider>().consultando(context);
                  ejecutar();
                },
                icon: const Icon(CupertinoIcons.search_circle)),
            label: const Text('BUSCAR...')),
      ),
    );
  }
}
