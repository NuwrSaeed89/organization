import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';

import 'package:winto/features/organization/e_commerce/features/product/controllers/floating_button_vendor_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/favorite_widget.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_mini.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu_black_product.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu_black_type2.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/images/custom_image.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/formatters/formatter.dart';

class ProductWidgetSmall extends StatelessWidget {
  const ProductWidgetSmall(
      {super.key, required this.product, required this.vendorId});
  final ProductModel product;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
     bool edit = false;
    if (vendorId == FirebaseAuth.instance.currentUser!.uid) {
      edit = true;
    }

     
    final controller = ProductController.instance;

    var oldPrice=product.oldPrice??0;
    final salePrecentage =
        controller.calculateSalePresentage(product.price, product.oldPrice) ??
            0;
    // String ratting =
    //     product.rating != null && product.rating!.isNotEmpty
    //         ? product.rating![0].average!
    //         : "0";

    return InkWell(
      onTap: () {
         Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>ProductDetails(
                product: product,
                vendorId: product.vendorId,
              ),));
     
          
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: TSizes.paddingSizeSmall),
        decoration: BoxDecoration(

          color: Colors.transparent
        ),
        child:
         Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            TProductImageSliderMini(
              product: product,
              prefferHeight: 127*(4/3),
              prefferWidth: 127,
              radius: BorderRadius.circular(15),
            ),

            // Product Details
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    height: 10),

                  ProductController.getTitle(product ,isLocaleEn(context),13,1 ),
                       
                      // textAlign: TextAlign.center,
                      // style: titilliumBold.copyWith(
                      //     fontSize: 14, fontWeight: FontWeight.w400),
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis),
                //  SizedBox(height: 2),

       

                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
            if (product.oldPrice !=null)
                  //   TCustomWidgets.viewSalePrice(oldPrice.toString(),12),
                   
                     TCustomWidgets.formattedPrice( product.price,'AED',15)
                   
                    ],
                  ),
               
                ],
              ),
            ),
          ]),
              Visibility(
                visible: false,
                child: Positioned(
                top: 0,
              right: 0,
                  child: ControlPanelBlackProducttype2(editMode: edit,
                  product: product,vendorId: vendorId,withCircle: true,)
                ),
              ),
          Visibility(
            visible: false,
            child: Positioned(
              top: 5,
              right: 5,
              child: FavouriteButton(
                editMode: false,
                product: product,
              ),
            ),
          ),
          Visibility(
            visible: false,
            child: Positioned(
              bottom: 75,
              left: 5,
              child: SavedButton(
                product: product,
              ),
            ),
          ),
          // Off
          if (salePrecentage != 0)
            Visibility(
              visible: salePrecentage.toString() != 0.toString(),
              child: Positioned(
                top: 20,
                left: 0,
                child: Container(
                  height: 20,
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.paddingSizeExtraSmall),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(TSizes.paddingSizeExtraSmall),
                        // topLeft: Radius.circular(TSizes.paddingSizeExtraSmall),
                        bottomRight:
                            Radius.circular(TSizes.paddingSizeExtraSmall)),
                  ),
                  child: Center(
                    child: Text('$salePrecentage %',
                        // PriceConverter.percentageCalculation(
                        //     context,
                        //     product.unitPrice,
                        //     product.discount,
                        //     product.discountType),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Colors.white,
                                fontSize: TSizes.fontSizeSmall)),
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
