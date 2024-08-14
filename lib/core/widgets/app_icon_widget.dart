import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final image;

  const AppIconWidget({
    super.key,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    //getting screen size
    var size = MediaQuery.of(context).size;

    //calculating container width
    double imageSize;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      imageSize = (size.width * 0.20);
    } else {
      imageSize = (size.height * 0.20);
    }

    return Image.asset(
      image,
      height: imageSize,
    );
  }
}