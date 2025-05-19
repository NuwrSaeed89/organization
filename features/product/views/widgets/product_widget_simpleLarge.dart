import 'package:flutter/material.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_mini.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class ProductWidgetSmall2 extends StatelessWidget {
  const ProductWidgetSmall2({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePrecentage =
        controller.calculateSalePresentage(product.price, product.oldPrice);
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
        decoration: const BoxDecoration(),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
                height: 300,
                width: 150,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: TProductImageSliderMini(
                  product: product,
                  prefferHeight: 300,
                )),

            // Product Details
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 8),

                  Text( isArabicLocale() ? product.arabicTitle==''? product.title : product.arabicTitle : product.title,
                       
                      textAlign: TextAlign.center,
                      style: titilliumRegular.copyWith(fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),

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

                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        if (product.oldPrice !=null)
                     TCustomWidgets.viewSalePrice(product.oldPrice.toString(),12)
                   ,   const SizedBox(width: 10),
                      Text(product.price.toString(),
                          // PriceConverter.convertPrice(context, product.unitPrice,
                          //     discountType: product.discountType,
                          //     discount: product.discount),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontFamily: englishFonts, fontSize: 14)),
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

          // Off

          if (salePrecentage != 0.toString())
            Visibility(
              visible: true,
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
