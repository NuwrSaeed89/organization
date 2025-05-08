//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';
import 'package:winto/app/app_localization.dart';

class TValidator {
  ///Empty Text Validation

  static String? validateEmptyText(String? fieldName, String? value) {
    String g =
        AppLocalizations.of(Get.context!).translate('validator.requered');
    if (value == null || value.isEmpty) {
      return '$fieldName  $g';
    }
    return null;
  }

  static String? validateSaleprice(String? value, String? valuPrice) {
    var salePrice = double.parse(value!);
    var price = double.parse(valuPrice!);

    if (salePrice > price) {
      return 'سعر التخفيض يجب أن يكون أقل من السعر الأساسي';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is requeried.';
    }
    return null;
  }

  // static String? validatePhoneNumber(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return AppLocalizations.of(Get.context!)!.phoneRequired;
  //   }
  //   // final phoneRegExp = RegExp(r'^\d{10}$');
  //   // if (!phoneRegExp.hasMatch(value)) {
  //   //   return 'invalid phone number (10 digits requeried..)';
  //   // }
  //   return null;
  // }
}
