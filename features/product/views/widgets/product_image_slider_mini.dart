import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/circuler_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/social/presentation/widgets/posts/network/display/display_image_full.dart';

class TProductImageSliderMini extends StatelessWidget {
  const TProductImageSliderMini(
      {super.key,
      required this.product,
      this.prefferHeight,
      this.prefferWidth,
      this.radius});
  final ProductModel product;
  final BorderRadius? radius;
  final double? prefferHeight;
  final double? prefferWidth;
  @override
  Widget build(BuildContext context) {
    RxInt selectdindex = 0.obs;

    final images = product.images!;

    // final salePrecentage = ProductController.instance
    //     .calculateSalePresentage(product.price, product.salePrice);
    // final s = double.parse(salePrecentage!);
    if (images.length > 1) {
      return Stack(
        children: [
          TRoundedContainer(
              radius: BorderRadius.circular(15),
              showBorder: true,
                    enableShadow: true,
            child: CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, _) => selectdindex.value = index,
                height: prefferHeight ?? 220,
            
                viewportFraction: 1,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                // enlargeCenterPage: true,
              ),
                items: images
                  .map((item) => 
                 
                 
                  CachedNetworkImage(
                      imageUrl: item,
                      imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: radius ?? BorderRadius.circular(15),
                              color: TColors.light,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.fill),
                            ),
                          ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => ClipRRect(
                              //  borderRadius: BorderRadius.circular(0),
                              child: TShimmerEffect(
                                  raduis: BorderRadius.circular(15),
                                  width: prefferWidth ?? 120,
                                
                                  height: prefferHeight ?? 220)),
                      errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 50,
                          )))
                 
                  .toList(),
            ),
          ),
          if (images.length > 1)
            Positioned(
              bottom: 12,
              left: 4,
              right: 4,
              child: SizedBox(
                height: 4,
                child: Center(
                  child: ListView.separated(
                    itemCount: images.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => Obx(
                      () => TRoundedContainer(
                        width: index == selectdindex.value ? 8 : 4,
                       enableShadow: true,
                        radius: BorderRadius.circular(100),
                        showBorder: true,
                        //  height: .5,
                        // margin: const EdgeInsets.only(right: 2, left: 2),
                        backgroundColor: index == selectdindex.value
                            ? TColors.primary
                            : TColors.white,
                      ),
                    ),
                    separatorBuilder: (_, __) => const SizedBox(
                      width: TSizes.spaceBtWItems / 3,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    } else if (images.length == 1) {
      return TRoundedContainer(
        width: prefferWidth ?? 120,
        height: prefferHeight ?? 220,
        showBorder: true,
       // borderColor: Colors.red,
        radius: radius ?? BorderRadius.circular(15),
       // enableShadow: true,
        child: CustomCaChedNetworkImage(
            width: prefferWidth ?? 120,
            height: prefferHeight ?? 220,
            url: images.first,
            raduis: radius ?? BorderRadius.circular(15)),
      );
    } else {
      return ClipRRect(
        borderRadius: radius ?? BorderRadius.circular(15),
        child: Image(
          image: const AssetImage(TImages.imagePlaceholder),
          width: prefferWidth ?? 120,
          height: prefferHeight ?? 220,
        ),
      );
    }
  }
}
