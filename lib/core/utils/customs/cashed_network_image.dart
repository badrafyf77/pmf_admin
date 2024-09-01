import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomCashedNetworkImage extends StatelessWidget {
  const CustomCashedNetworkImage({
    super.key,
    required this.url,
    this.width,
    this.height,
  });

  final String url;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      height: (height == null) ? null : height,
      width: (width == null) ? null : width,
      fit: BoxFit.fill,
      placeholder: (context, url) => Skeletonizer(
        enabled: true,
        child: SizedBox(
          height: height,
          width: width,
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
