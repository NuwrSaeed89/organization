import 'package:flutter/material.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_mini.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

import 'favorite_widget.dart';

class ProductWidgetMedium extends StatelessWidget {
  const ProductWidgetMedium(
      {super.key,
      required this.product,
      required this.vendorId,
      required this.editMode,
      this.prefferHeight,
      this.prefferWidth});
  final ProductModel product;
  final double? prefferHeight;
  final double? prefferWidth;
  final bool editMode;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePrecentage =
        controller.calculateSalePresentage(product.price, product.salePrice);
    // String ratting =
    //     product.rating != null && product.rating!.isNotEmpty
    //         ? product.rating![0].average!
    //         : "0";

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) => ProductDetails(
                product: product,
                vendorId: vendorId,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: TSizes.paddingSizeSmall),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: TColors.lightgrey,
            border: Border.all(color: TColors.grey)
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.grey.withValues(alpha: 0.2),
            //       spreadRadius: 1,
            //       blurRadius: 5)
            // ],
            ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
                height: prefferHeight ?? 200,
                width: prefferWidth ?? 150,
                decoration: BoxDecoration(
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withValues(alpha: .5),
                  //     spreadRadius: 1,
                  //     blurRadius: 5,
                  //     offset: const Offset(0, 3),
                  //   ),
                  // ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                ),
                child: TProductImageSliderMini(
                  product: product,
                  radius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  prefferHeight: prefferHeight,
                  prefferWidth: prefferWidth,
                  // prefferWidth: 174,
                )),

            // Product Details
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 12),
                  Text(isArabicLocale() ? product.arabicTitle : product.title,
                      textAlign: TextAlign.center,
                      style: robotoRegular.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (product.salePrice < product.price)
                        Text(product.price.toString(),
                            // PriceConverter.convertPrice(
                            //     context, product.unitPrice),
                            style: titilliumSemiBold.copyWith(
                                color: TColors.darkGrey,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12)),
                      const SizedBox(width: 10),
                      Text(product.salePrice.toString(),
                          // PriceConverter.convertPrice(context, product.unitPrice,
                          //     discountType: product.discountType,
                          //     discount: product.discount),
                          style: titilliumSemiBold.copyWith(
                              color: Colors.blueAccent))
                    ],
                  )
                ],
              ),
            ),
          ]),

          // Off

          if (salePrecentage != null)
            Positioned(
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
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Colors.white, fontSize: TSizes.fontSizeSmall)),
                ),
              ),
            ),

          Positioned(
            top: 5,
            right: 5,
            child: FavouriteButton(
              editMode: editMode,
              productId: product.id,
            ),
          ),
          Visibility(
            visible: true,
            child: Positioned(
              bottom: 78,
              left: 5,
              child: SavedButton(
                product: product,
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
