import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  RxBool like = false.obs;
  final String? productId;
  final bool editMode;
  final bool withBackground;
 final double size ;
  FavouriteButton(
      {super.key,
      this.backgroundColor = Colors.black,
      this.productId,
      this.withBackground=true,
      this.size=19,
      this.editMode = false});

  @override
  Widget build(BuildContext context) {
    //  bool isGuestMode = false;

    return GestureDetector(
      onTap: () {
        like.value = !like.value;
      },
      child: TRoundedContainer(
        width: size+6,
        height: size+6,
        radius: BorderRadius.circular(100),
        // enableShadow:  withBackground,
        // showBorder: true,
        backgroundColor:withBackground? TColors.white: Colors.transparent,
         child:
        // editMode
        //     ? Center(
        //         child: Padding(
        //             padding: const EdgeInsets.all(2),
        //             child: const Icon(CupertinoIcons.heart,
        //                 // : CupertinoIcons.heart,
        //                 // color: const Color(0xFFFF5050),
        //                 color: Colors.black,
        //                 size: 24)),
        //       )
            Center(
                child: Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(2),
                    child: !like.value
                        ?  Icon(CupertinoIcons.heart,
                            // : CupertinoIcons.heart,
                            // color: const Color(0xFFFF5050),
                            color: Colors.black,
                            size: size)
                        :  Icon(CupertinoIcons.heart_fill,
                            // : CupertinoIcons.heart,
                            // color: const Color(0xFFFF5050),
                            color: Colors.red,
                            size: size),
                  ),
                ),
              ),
      ),
    );
  }
}
