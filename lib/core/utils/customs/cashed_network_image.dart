import 'package:flutter/material.dart';
import 'package:pmf_admin/core/utils/assets.dart';

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
    return Image.asset(
      AppAssets.logo,
      height: height,
      width: width,
    );
    // return CachedNetworkImage(
    //   imageUrl: url,
    //   height: (height == null) ? null : height,
    //   width: (width == null) ? null : width,
    //   fit: BoxFit.fill,
    //   placeholder: (context, url) => Skeletonizer(
    //     enabled: true,
    //     child: SizedBox(
    //       height: height,
    //       width: width,
    //     ),
    //   ),
    //   errorWidget: (context, url, error) => const Icon(Icons.error),
    // );
  }
}
