import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_mini.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/images/custom_image.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class ProductWidgetHorzental extends StatelessWidget {
  const ProductWidgetHorzental(
      {super.key, required this.product, required this.vendorId});
  final ProductModel product;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
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
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) => ProductDetails(
                 key: UniqueKey(),
                product: product,
                vendorId: product.vendorId,
              ),
            ));
      },
      child:
      
      
       Column(
         children: [


                   Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 1,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                   Container( width: 130,
                     height: 160,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: TProductImageSliderMini(
                        product: product,
                        prefferHeight: 170,
                        prefferWidth: 127,
                      )),
                      SizedBox(width: 15,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                                 
                      children: [
                        
            const SizedBox(height: 10),
                    ProductController.getTitle(product ,isLocaleEn(context), 16,2 ),
                                           
                    const SizedBox(
                      height: 8,
                    ),
                     Text(isArabicLocale() ? product.arabicDescription! : product.description!,
                       
                        style: robotoRegular.copyWith(
                            fontSize: 13,
                            
                             fontWeight: FontWeight.normal,color: TColors.darkerGray),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                        SizedBox(height: 8),
                           TCustomWidgets.formattedPrice( product.price,'AED',18),
                        SizedBox(height: 8),
                       
                      
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
           Visibility(
            visible: false,
             child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
              
                decoration: BoxDecoration(),
                child: Row( 
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  Container(width: 300,
                     height: 127,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(15)),
                      child: TProductImageSliderMini(
                        product: product,
                        prefferHeight: 170,
                        prefferWidth: 127,
                      )),
                
                  // Product Details
                  SizedBox(
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: <Widget>[
                        SizedBox(height: 8),
                                  
                        Text( isArabicLocale() ? product.arabicTitle==''? product.title : product.arabicTitle : product.title,
                       
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
                               if (product.oldPrice !=null)
                     TCustomWidgets.viewSalePrice(product.oldPrice.toString(),12)
                           , SizedBox(height: 4),
                             TCustomWidgets.formattedPrice( product.price,'AED',13)
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
              ),
                   ),
           ),
         ],
       ),
    );
  }
}
