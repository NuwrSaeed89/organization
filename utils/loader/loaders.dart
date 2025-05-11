import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class TLoader {
  static successSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        titleText: Text(
          title,
          style: titilliumBold,
        ),
        messageText: Text(
          message,
          style: titilliumSemiBold,
        ),
        maxWidth: 500,
        
        backgroundColor: TColors.lightgrey,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.all(10),
        icon: const Icon(Icons.check, color: Colors.white));
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        titleText: Text(
          title,
          style: titilliumBold,
        ),
        messageText: Text(
          message,
          style: titilliumSemiBold,
        ),
        colorText: Colors.black,
        maxWidth: 600,
        backgroundColor: Colors.grey,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Icons.warning, color: Colors.white));
  }

  static erroreSnackBar({required title, message = ''}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        titleText: Text(
          title,
          style: titilliumBold,
        ),
        messageText: Text(
          message,
          style: titilliumSemiBold,
        ),
        maxWidth: 600,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
        margin: const EdgeInsets.all(20),
        icon: const Icon(Icons.error, color: Colors.white));
  }
}

class LoadingFullscreen {
  static void startLoading() {
    Get.dialog(const SimpleDialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      children: <Widget>[
        Center(
          child: CircularProgressIndicator.adaptive(),
        )
      ],
    ));
  }

  static stopLoading() {
    Get.close(1);
  }
}
