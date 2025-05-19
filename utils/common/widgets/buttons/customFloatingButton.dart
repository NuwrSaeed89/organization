import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class CustomFloatActionButton extends StatelessWidget {
  CustomFloatActionButton(
      {super.key, required this.onTap, this.icon = CupertinoIcons.add, this.isIcon=true, this.widget});
  final VoidCallback onTap;
  final IconData icon;
  final bool isIcon;
  Widget? widget;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,

      elevation: 0,
      foregroundColor: Colors.transparent,
      //focusColor: TColors.primary,
      onPressed: onTap,

      child: Center(
          child: TRoundedContainer(
        enableShadow: true,
        width: 50,
        height: 50,
        radius: BorderRadius.circular(300),
        child:   isIcon? Icon(icon
  ,
          color: TColors.primary,
        ): widget,
      )),
    );
  }
}
