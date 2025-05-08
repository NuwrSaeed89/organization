import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

var titilliumRegular = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontWeight: FontWeight.w400,
  fontSize: TSizes.fontSizeDefault,
);

var titilliumSemiBold = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontSize: TSizes.fontSizeLarge,
  fontWeight: FontWeight.w500,
);

var titilliumBold = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontSize: TSizes.fontSizeDefault,
  fontWeight: FontWeight.w600,
);
var titilliumItalic = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontSize: TSizes.fontSizeDefault,
  fontStyle: FontStyle.italic,
);

var robotoHintRegular = TextStyle(
    fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
    fontWeight: FontWeight.w400,
    fontSize: TSizes.fontSizeSmall,
    color: Colors.grey);
var robotoRegular = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontWeight: FontWeight.w400,
  fontSize: TSizes.fontSizeDefault,
);
var robotoRegularMainHeadingAddProduct = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontWeight: FontWeight.w400,
  fontSize: TSizes.fontSizeDefault,
);

var robotoRegularForAddProductHeading = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  color: Color(0xFF9D9D9D),
  fontWeight: FontWeight.w400,
  fontSize: TSizes.fontSizeSmall,
);

var robotoTitleRegular = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontWeight: FontWeight.w400,
  fontSize: TSizes.fontSizeLarge,
);

var robotoSmallTitleRegular = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontWeight: FontWeight.w400,
  fontSize: TSizes.fontSizeSmall,
);

var robotoBold = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontSize: TSizes.fontSizeDefault,
  fontWeight: FontWeight.w600,
);

var robotoMedium = TextStyle(
  fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
  fontSize: TSizes.fontSizeDefault,
  fontWeight: FontWeight.w500,
);

class ThemeShadow {
  static List<BoxShadow> getShadow(BuildContext context) {
    List<BoxShadow> boxShadow = [
      BoxShadow(
          color: Theme.of(context).primaryColor.withValues(alpha: .075),
          blurRadius: 5,
          spreadRadius: 1,
          offset: const Offset(1, 1))
    ];
    return boxShadow;
  }
}
