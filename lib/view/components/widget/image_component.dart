import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fpladm/view/config/pallet.dart';

class ImageComponent extends StatelessWidget {
  String imageUrl;
  double size;
  Widget errorWidget;
  Function function;

  ImageComponent(
      {super.key,
      required this.imageUrl,
      required this.size,
      required this.errorWidget,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      /*imageBuilder: (context, imageProvider) => InkWell(
        splashColor: Colors.lightGreen,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onTap: () {
          function();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.lightGreen,
              border: Border.all(color: Colors.lightGreen, width: 2),
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),*/
      imageBuilder: (context, imageProvider) => InkWell(
        splashColor: Colors.green,
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onTap: () {
          function();
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green, width: 2),
              shape: BoxShape.circle),
          child: CircleAvatar(
            radius: size,
            backgroundImage: imageProvider,
            backgroundColor: Colors.green,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}
