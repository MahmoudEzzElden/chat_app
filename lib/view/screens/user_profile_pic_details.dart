import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PictureMagnifier extends StatelessWidget {
  static const String routeName = 'PictureMagnifier';

  const PictureMagnifier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Hero(tag: url, child: CachedNetworkImage(imageUrl: url)),
      ),
    );
  }
}
