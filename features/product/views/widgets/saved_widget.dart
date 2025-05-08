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

  const SavedButton({
    super.key,
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
        child: Obx(
          () =>
         // Transform.rotate(angle: 45,
          Icon( !like.value ?Icons.data_saver_on_outlined:Icons.download_done_outlined, size:23),
          
          
          
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
