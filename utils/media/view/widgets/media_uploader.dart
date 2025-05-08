import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

import '../../controller/media_controller.dart';

class MediaUploader extends StatelessWidget {
  const MediaUploader({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MediaController());
    return Obx(
      () => Column(
        children: [
          TRoundedContainer(
            radius: BorderRadius.circular(20),
            // height: controller.selectedImage.length <= 2
            //     ? 300
            //     : (controller.selectedImage.length * 100) + 200,
            width: 370.w,
            showBorder: true,
            borderColor: TColors.borderPrimary,
            backgroundColor: TColors.primaryBackground,
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: 
            Column(
              children: [
                Text(
                  "Add Images here",
                ),
                SizedBox(
                  height: TSizes.spaceBtWItems,
                ),
                Stack(alignment: Alignment.center, children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: controller.selectedImage.isEmpty,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => controller.selectImages(true),
                              child: DottedBorder(
                                dashPattern: const [4, 5],
                                borderType: BorderType.RRect,
                                color: TColors.darkerGray,
                                radius: const Radius.circular(15),
                                child: TRoundedContainer(
                                  width: 25.w,
                                  height: 25.w,
                                  radius: BorderRadius.circular(20),
                                  child: SizedBox(
                                    width: 15,
                                    child: Image.asset(
                                      TImages.imagePlaceholder,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtWItems,
                            ),

                            //    if (controller.selectedImage.isEmpty)
                          ],
                        ),
                      ),
                      if (controller.selectedImage.isNotEmpty)
                        Wrap(children: [
                          for (var image in controller.selectedImage)
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width: 75,
                                    height: 75,
                                    child: Image.file(
                                      File(image.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      onPressed: () => controller.selectedImage
                                          .remove(image),
                                      icon: const Icon(
                                        Icons.delete_rounded,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          GestureDetector(
                            onTap: () => controller.selectImages(true),
                            child: TRoundedContainer(
                              width: 75,
                              height: 75,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ]),
                    ],
                  ),
                ]),
              
              ],
            ),
          )
        ],
      ),
    );
  }
}
