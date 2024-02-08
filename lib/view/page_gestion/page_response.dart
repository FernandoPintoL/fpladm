import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app/models/http_response.dart';

class PageResponse extends StatelessWidget {
  bool isLoading;
  HttpResponsse httpResponsse;

  PageResponse(
      {super.key, this.isLoading = false, required this.httpResponsse});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          httpResponsse.isRequest
              ? const SizedBox(height: 1)
              : const Text(
                  "Nuestros servidores estan en mantenimiento intente mas tarde porfavor"),
          const SizedBox(height: 15),
          Text("Message: '${httpResponsse.message}'"),
          const SizedBox(height: 30),
          IconButton(
              onPressed: () {
                //context.read<UserProvider>().cargandoLista("");
              },
              icon: const Icon(CupertinoIcons.arrow_2_circlepath)),
        ],
      ),
    );
  }
}
