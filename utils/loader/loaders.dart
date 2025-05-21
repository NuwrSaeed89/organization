import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class TLoader {
  static successSnackBar({required title, message = '', duration = 4}) {
    Get.snackbar("", message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: TColors.primary,
        messageText: Text(
          message,
          style: titilliumBold.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        // messageText: Text(
        //   message,
        //   style: titilliumSemiBold.copyWith(fontWeight: FontWeight.bold),
        // ),
        maxWidth: 400,
        
        backgroundColor: TColors.white,
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: duration),
       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
     // icon: const Icon(Icons.check, color: TColors.primary,),
       
        );
  }

  static warningSnackBar({required title, message = ''}) {
    Get.snackbar("", message,
     
        isDismissible: true,
        shouldIconPulse: true,
         colorText: TColors.warning,
      
       messageText: Text(
          message,
          style: titilliumBold.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        showProgressIndicator: true,
        
      
        maxWidth: 300,
         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        backgroundColor:TColors.warning.withValues(alpha: .5),
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),

      //  icon: const Icon(Icons.warning, color:TColors.warning)
        );
  }

  static erroreSnackBar({required title, message = ''}) {
    Get.snackbar(message, "",
        isDismissible: true,
        shouldIconPulse: true,
         colorText: TColors.red,
        titleText: Text(
          message,
          style: titilliumBold,
        ),
        // messageText: Text(
        //   message,
        //   style: titilliumSemiBold,
        // ),
        maxWidth: 600,
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 5),
       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      //  icon: const Icon(Icons.error, color: Colors.red)
      );
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
