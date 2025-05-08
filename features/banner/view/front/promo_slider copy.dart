import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/banner/controller/banner_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/circuler_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider(
      {super.key,
      this.autoPlay = true,
      this.editMode = false,
      required this.vendorId});
  final bool editMode;
  final bool autoPlay;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    controller.fetchBanners(vendorId);
    List<String> images = controller.activeBanners.map((e) => e.image).toList();
    return Obx(() {
      if (controller.isLoading.value) {
        return const TShimmerEffect(width: double.infinity, height: 214);
      }
      if (images.isEmpty) {
        return Center(
            child: editMode
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: TShimmerEffect(
                          width: 92.w,
                          height: 60.w,
                          raduis: BorderRadius.circular(20),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () =>
                                    controller.addBanner('gallery', vendorId),
                                icon: const Icon(
                                  CupertinoIcons.add_circled,
                                  size: 40,
                                )),
                            Text(isLocaleEn(context)
                                ? 'Add Banner'
                                : "اضافة بنر")
                          ],
                        ),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TShimmerEffect(
                        raduis: BorderRadius.circular(20),
                        width: 80.w,
                        height: 75.w - 100),
                  ));
      }
      return Stack(
        children: [
          Obx(
            () => CarouselSlider(
              options: CarouselOptions(
                  //  aspectRatio: 9 / 6,
                  viewportFraction: 0.80,
                  autoPlay: true,
                  height: 190,
                  enlargeCenterPage: true,

                  // autoPlay: true,
                  // enlargeCenterPage: true,
                  // aspectRatio: 3 / 1,
                  // autoPlayCurve: Curves.linear,
                  // viewportFraction: 0.8,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index)),
              items: controller.activeBanners
                  // .map((imagePath) => Container(
                  //       //margin: EdgeInsets.symmetric(horizontal: 8.0),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         image: DecorationImage(
                  //           image: NetworkImage(imagePath.image),
                  //           fit: BoxFit.cover,
                  //         ),
                  //       ),
                  //     ))
                  // .toList(),
                  .map((e) => e.image)
                  .toList()
                  .map((item) => CachedNetworkImage(
                      fit: BoxFit.fill,
                      // width: THelperFunctions.screenwidth() ,
                      //height: THelperFunctions.screenwidth() / 1.7,
                      // color: TColors.darkGrey.withOpacity(0.1),
                      imageUrl: item,
                      imageBuilder: (context, imageProvider) => GestureDetector(
                            onTap: () {
                              // Get.to(GalleryWidget(
                              //     urlImage: images, index: images.indexOf(item)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Container(
                                // width: 75.w,
                                // height: 75.w,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fitWidth),
                                ),
                              ),
                            ),
                          ),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: TShimmerEffect(
                                  raduis: BorderRadius.circular(20),
                                  width: 75.w,
                                  height: 75.w - 150)),
                      errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            size: 50,
                          )))
                  .toList(),
            ),
          ),
          Visibility(
            visible: false,
            child: Positioned(
              bottom: 6,
              left: 2,
              right: 2,
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < images.length; i++)
                      TCirculerContainer(
                        width: 15,
                        height: 5,
                        margin: const EdgeInsets.only(right: 5, left: 5),
                        backgroundColor:
                            controller.carousalCurrentIndex.value == i
                                ? TColors.primary
                                : TColors.lightgrey,
                      )
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
