import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SocialMediaController extends GetxController {
  var startIndex = 0.obs;
  final List<String> icons = [
    'assets/images/ecommerce/icons/location.svg',
    'assets/images/ecommerce/icons/gmail.svg',
    'assets/images/ecommerce/icons/phone.svg',
    'assets/images/ecommerce/icons/linkin.svg',
    'assets/images/ecommerce/icons/youtube.svg',
    'assets/images/ecommerce/icons/facebook.svg',
    'assets/images/ecommerce/icons/insta.svg',
  ]; // استبدل بمسارات الأيقونات الخاصة بك

  void next() {
    if (startIndex.value + 6 < icons.length) {
      startIndex.value += 6;
    }
  }

  void previous() {
    if (startIndex.value > 0) {
      startIndex.value -= 6;
    }
  }
}

class SocialMediaIcons extends StatelessWidget {
  final SocialMediaController controller = Get.put(SocialMediaController());

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(() {
          return Visibility(
            visible: controller.startIndex.value > 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: controller.previous,
            ),
          );
        }),
        Obx(() {
          return SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:
                  controller.startIndex.value + 6 > controller.icons.length
                      ? controller.icons.length - controller.startIndex.value
                      : 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    controller.icons[controller.startIndex.value + index],
                    width: 25,
                    height: 25,
                  ),
                );
              },
            ),
          );
        }),
        Obx(() {
          return Visibility(
            visible: controller.startIndex.value + 6 < controller.icons.length,
            child: IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: controller.next,
            ),
          );
        }),
      ],
    );
  }
}
