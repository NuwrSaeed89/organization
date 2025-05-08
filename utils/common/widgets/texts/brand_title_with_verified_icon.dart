// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/texts/brand_title_text.dart';
import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class TBrandTitleWithVerifiedIcon extends StatelessWidget {
  const TBrandTitleWithVerifiedIcon(
      {Key? key,
      this.title = " ",
      this.textColor,
      this.maxLines = 1,
      this.iconColor = TColors.primary,
      this.textAlign = TextAlign.center,
      this.brandTextSize = TextSizes.small})
      : super(key: key);

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: TBrandTitleText(
          title: title,
          color: textColor,
          maxLines: maxLines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        )),
        const SizedBox(height: TSizes.xs),
        const Icon(
          Icons.verified,
          color: TColors.primary,
          size: 20,
        )
      ],
    );
  }
}
