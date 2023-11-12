import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AssetImageWidget extends StatelessWidget {
  String? assetImage;
  BoxFit? boxFit;
  AssetImageWidget({super.key, this.assetImage,this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Image.asset(assetImage ?? "",fit: boxFit ?? BoxFit.cover,);
  }
}
