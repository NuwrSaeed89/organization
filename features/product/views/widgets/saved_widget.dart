import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';

class SavedButton extends StatelessWidget {
  final Color backgroundColor;

  final ProductModel product;
final double size;
  const SavedButton({
    super.key,
    this.size=18,
    this.backgroundColor = Colors.black,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    var controller = SavedProductsController.instance;
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
      child: Center(
        child:
         // Transform.rotate(angle: 45,
          TRoundedContainer(
       width: size+7,
       height: size+7,
            radius: BorderRadius.circular(300),
          backgroundColor: Colors.transparent,

            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Obx(
          () => Icon( !like.value ?Icons.bookmark_border :Icons.bookmark_outlined, size:size, color: Colors.black,),
            )),
          
          
          
          )
          // SvgPicture.asset(
          //   !like.value
          //       ? 'assets/images/ecommerce/icons/unsaved.svg'
          //       : 'assets/images/ecommerce/icons/saved.svg',
          //   width: 50,
          //   height: 50,
          // ),
        ),
      
    );
  }
}
