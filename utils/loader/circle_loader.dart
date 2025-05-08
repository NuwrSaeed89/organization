import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class TLoaderWidget extends StatelessWidget {
  const TLoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.hexagonDots(
      color: TColors.black,
      size: 15.w,
    ));
  }
}
