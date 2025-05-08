import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class CustomButton extends StatelessWidget {
  final Function? onTap;
  final String? btnTxt;
  final bool isColor;
  final Color? backgroundColor;
  final Color? fontColor;
  final double? borderRadius;
  const CustomButton(
      {Key? key,
      this.onTap,
      required this.btnTxt,
      this.backgroundColor,
      this.isColor = false,
      this.fontColor,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isColor ? backgroundColor : backgroundColor ?? Colors.black,
            borderRadius: BorderRadius.circular(
                borderRadius != null ? borderRadius! : TSizes.sm)),
        child: Text(btnTxt!,
            style: TextStyle(
              fontSize: TSizes.defaultSpace,
              color: fontColor ?? Colors.white,
            )),
      ),
    );
  }
}
