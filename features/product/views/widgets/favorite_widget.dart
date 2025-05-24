import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/favorite_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class FavouriteButton extends StatelessWidget {
  final Color backgroundColor;
  RxBool like = false.obs;
  final ProductModel  product;
  final bool editMode;
  final bool withBackground;
 final double size ;
  FavouriteButton(
      {super.key,
      this.backgroundColor = Colors.black,
     required  this.product,
      this.withBackground=true,
      this.size=19,
      this.editMode = false});

  @override
  Widget build(BuildContext context) {
    //  bool isGuestMode = false;
 var controller = FavoriteProductsController.instance;
    //  bool isGuestMode = false;
    //RxBool like = false.obs;
    var like = controller.isSaved(product.id).obs;
    return GestureDetector(
      onTap: () {
         if (like.value) {
          controller.removeProduct(product.id);
          like.value = !like.value;
        } else {
          controller.saveProduct(product);
          like.value = !like.value;
        }
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
