import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  const CachedNetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width = 60,
    this.height = 90,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: BoxFit.fill,
      placeholder:
          (context, url) => Container(
            width: width,
            height: height,
            color: Colors.grey.shade300,
            child: const Icon(Icons.image, color: Colors.white),
          ),
      errorWidget:
          (context, url, error) => Container(
            width: width,
            height: height,
            color: Colors.grey.shade300,
            child: const Icon(Icons.broken_image),
          ),
    );
  }
}
