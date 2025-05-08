// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/device/device_utility.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({
    Key? key,
    this.title,
    this.backgroundColor,
    this.showBackArrow = false,
    this.leadingIcon,
    this.actions,
    this.centerTitle = false,
    this.leadingOnPress,
    this.onbackPress,
  }) : super(key: key);

  final Widget? title;
  final Color? backgroundColor;
  final bool showBackArrow;
  final bool? centerTitle;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPress;
  final VoidCallback? onbackPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: onbackPress ?? () => Get.back(),
                icon: Icon(
                  Get.locale?.languageCode == 'en'
                      ? Icons.keyboard_arrow_left
                      : Icons.keyboard_arrow_right,
                  size: 30,
                ))
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPress,
                    icon: Icon(
                      leadingIcon,
                      color: Colors.white,
                    ))
                : null,
        title: title,
        titleTextStyle: Theme.of(context).textTheme.headlineSmall,
        centerTitle: centerTitle,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppbarHeight());
}
