import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AvatarImage extends StatelessWidget {
  final String imagePath;
  final IconButton? childButton;
  final double radius;
  // Constructor
  const AvatarImage({Key? key, required this.imagePath, this.childButton, this.radius = 70}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [_buildImage(context, radius), if (childButton != null) Positioned(child: _buildCircle(), right: 4, top: 10)],
      ),
    );
  }

  // Builds Profile Image
  Widget _buildImage(BuildContext context, double radius) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: CachedNetworkImage(
        placeholder: (_, __) => const CircularProgressIndicator(color: Colors.white),
        imageUrl: imagePath,
        errorWidget: (_, __, ___) => const Icon(Icons.image_outlined, color: Colors.white, size: 70),
      ),
    );
  }

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget _buildCircle() {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: childButton,
      ),
    );
  }
}
