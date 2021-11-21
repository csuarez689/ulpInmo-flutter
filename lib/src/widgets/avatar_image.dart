import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String imagePath;
  final IconButton? childButton;
  final Color bgColor;
  // Constructor
  const AvatarImage({Key? key, required this.imagePath, this.childButton, required this.bgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [buildImage(bgColor), if (childButton != null) Positioned(child: buildCircle(), right: 4, top: 10)],
      ),
    );
  }

  // Builds Profile Image
  Widget buildImage(Color color) {
    return CircleAvatar(
      radius: 70,
      backgroundColor: color,
      child: CachedNetworkImage(
          // placeholder: (_, __) => Image.asset('assets/imgs/pink-white-loader.gif'),
          placeholder: (_, __) => const CircularProgressIndicator(color: Colors.white),
          imageUrl: imagePath,
          errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.white, size: 30)),
    );
  }

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle() {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: childButton,
      ),
    );
  }
}
