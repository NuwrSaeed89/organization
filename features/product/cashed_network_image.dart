import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class CustomCaChedNetworkImage extends StatelessWidget {
  const CustomCaChedNetworkImage(
      {super.key,
      required this.width,
      required this.height,
      required this.url,
      this.enableShadow = true,
      required this.raduis});
  final double width;
  final double height;
  final bool enableShadow;
  final BorderRadius raduis;
  final String url;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                boxShadow: enableShadow
                    ?TColors.tboxShadow
                    : null,
                borderRadius: raduis,
                color: TColors.light,
                image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => ClipRRect(
                //  borderRadius: BorderRadius.circular(0),
                child: TShimmerEffect(
              width: width,
              height: height,
              raduis: raduis,
            )),
        errorWidget: (context, url, error) => const Icon(
              Icons.error,
              size: 50,
            ));
  }
}
