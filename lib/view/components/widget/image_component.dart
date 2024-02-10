import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageComponent extends StatelessWidget {
  String imageUrl;
  double size;
  Widget errorWidget;

  ImageComponent(
      {super.key,
      required this.imageUrl,
      required this.size,
      required this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.indigo,
              width: 2.0,
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
      ),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => errorWidget,
    );
  }
}
