import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/dynamic_all_product.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class TCategoryGridItem extends StatelessWidget {
  TCategoryGridItem(
      {super.key,
      required this.category,
      required this.editMode,
      required this.vendorId});
  final CategoryModel category;

  final bool editMode;
  final String vendorId;

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: TColors.grey,
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(
                    color: TColors.white,
                    strokeAlign: BorderSide.strokeAlignOutside),
                color: TColors.white,
                borderRadius: BorderRadius.circular(100)),
            child: Center(
                child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: category.image!,
                    imageBuilder: (context, imageProvider) => GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllProducts(
                                        title: Get.locale?.languageCode == 'en'
                                            ? category.name
                                            : category.arabicName,
                                        categoryId: category.id!,
                                        editMode: true,
                                        vendorId: vendorId,
                                        futureMethode: CategoryController
                                            .instance
                                            .getCategoryProduct(
                                                categoryId: category.id!,
                                                userId: FirebaseAuth
                                                    .instance.currentUser!.uid,
                                                limit: -1),
                                      ))),
                          child: Container(
                            // width: 80,
                            // height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(image: imageProvider),
                            ),
                          ),
                        ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => ClipRRect(
                            //  borderRadius: BorderRadius.circular(0),
                            child: TShimmerEffect(
                                raduis: BorderRadius.circular(100),
                                width: 65,
                                height: 65)),
                    errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          size: 50,
                        )))),

        const SizedBox(
          height: TSizes.spaceBtWItems / 2,
        ),
        Wrap(children: [
          SizedBox(
            width: 85,
            height: 35,
              child: Align(
                alignment: Alignment.topCenter,
              child: Text(
                isArabicLocale() ? category.arabicName : category.name,
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: titilliumRegular.copyWith(fontSize: 12),
              ),
            ),
          ),
        ])
        //   TCircularImage(
        //     // border: Border.all(color: TColors.red),
        //     image: category.image!,
        //     width: 100,
        //     height: 100,
        //     imageType: ImageType.network,
        //     fit: BoxFit.fill,
        //   ),
        //   const SizedBox(width: TSizes.sm),
        //   Center(
        //     child: SizedBox(
        //       width: 120,
        //       child: Text(
        //         (isArabicLocale()) ? category.arabicName : category.name,
        //         maxLines: 2,
        //         overflow: TextOverflow.ellipsis,
        //         style: Theme.of(context)
        //             .textTheme
        //             .titleSmall!
        //             .copyWith(fontSize: 11, fontFamily: 'Tajawal-Medium'),
        //       ),
        //     ),
        //   ),
      ],
    );
  }
}
