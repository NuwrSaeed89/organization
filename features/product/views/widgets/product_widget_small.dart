import 'package:flutter/material.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_mini.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/images/custom_image.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class ProductWidgetSmall extends StatelessWidget {
  const ProductWidgetSmall(
      {super.key, required this.product, required this.vendorId});
  final ProductModel product;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePrecentage =
        controller.calculateSalePresentage(product.price, product.salePrice) ??
            0;
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
                vendorId: product.vendorId,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: TSizes.paddingSizeSmall),
        decoration: BoxDecoration(),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
                height: 170,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: TProductImageSliderMini(
                  product: product,
                  prefferHeight: 170,
                  prefferWidth: 127,
                )),

            // Product Details
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 8),

                  Text(isArabicLocale() ? product.arabicTitle : product.title,
                      textAlign: TextAlign.center,
                      style: titilliumBold.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4),

                  // Text(
                  //     isArabicLocale()
                  //         ? product.arabicDescription!
                  //         : product.description!,
                  //     textAlign: TextAlign.center,
                  //     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  //         fontSize: TSizes.fontSizeDefault,
                  //         fontWeight: FontWeight.w400),
                  //     maxLines: 3,
                  //     overflow: TextOverflow.ellipsis),

                  Column(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      if (product.salePrice < product.price)
                        Text(product.price.toString(),
                            // PriceConverter.convertPrice(
                            //     context, product.unitPrice),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: TColors.darkerGray,
                                    fontFamily: englishFonts,
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 13)),
                      SizedBox(height: 4),
                      Text("${product.salePrice} AED",
                          // PriceConverter.convertPrice(context, product.unitPrice,
                          //     discountType: product.discountType,
                          //     discount: product.discount),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontFamily: englishFonts,
                                  fontSize: 13,
                                  color: TColors.primary)),
                    ],
                  ),
                  // SizedBox(height: 4),
                  // Padding(
                  //     padding: const EdgeInsets.only(bottom: 0),
                  //     child: Text("تبقى منه  ${product.stock}  ",
                  //         style:
                  //             robotoRegular.copyWith(color: TColors.primary))),
                ],
              ),
            ),
          ]),
          Visibility(
            visible: false,
            child: Positioned(
              bottom: 50,
              right: -10,
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
