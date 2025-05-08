// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/device/device_utility.dart';
import 'package:winto/features/organization/e_commerce/utils/helpers/helper_functions.dart';

class TSearchContainer extends StatelessWidget {
  TSearchContainer(
      {super.key,
      required this.text,
      this.icon,
      this.onChange,
      this.padding =
          const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      this.showBorder = false,
      this.showBackground = true,
      this.onTap,
      this.controller});

  final String text;
  final IconData? icon;
  final TextEditingController? controller;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  var onChange;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: padding,
          child: Container(
              height: 75,
              width: TDeviceUtils.getScreenWidth(context),
              padding: const EdgeInsets.all(TSizes.md),
              decoration: BoxDecoration(
                  color: TColors.white,
                  border: showBorder ? Border.all(color: Colors.grey) : null,
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: dark ? TColors.black : TColors.black,
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtWItems,
                  ),
                  TextFormField(
                    controller: controller,
                    //onChanged: onChange,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: dark ? TColors.black : TColors.black),
                  )
                ],
              ))),
    );
  }
}
