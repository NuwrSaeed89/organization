// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_horz.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class SavedProductsPage extends StatelessWidget {
  final SavedProductsController controller = Get.put(SavedProductsController());

  SavedProductsPage({super.key});
  // Example user ID

  @override
  Widget build(BuildContext context) {
    controller.fetchSavedProducts();

    return Scaffold(
      appBar: CustomAppBar(
        title: isLocaleEn(context) ? 'Saved Product' : 'قائمة الحفظ',
      ),
      body: SafeArea(
        child: Obx(() => controller.savedProducts.isEmpty?
        
        Center(child:  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
                                'assets/images/liquid_loading.gif',
                                width: 70.w,
                                height: 70.w,
                              ),
        
                              Text( isArabicLocale()? " لايوجد عناصر حتى الأن":"No Items yet",style: titilliumBold.copyWith(fontSize: 15),)
          ],
        ),)
        :
        
        
         Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: ListView.builder(
                // separatorBuilder: (context, index) =>
                //     TCustomWidgets.buildDivider(),
                itemCount: controller.savedProducts.length,
                itemBuilder: (context, index) {
                  var product = controller.savedProducts[index];
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: SizedBox(
                        
                            child: ProductWidgetHorzental(
                                product: product, vendorId: '')),
                      ),
                      Positioned(
                        left:isLocaleEn(context)? 10:null,
                           right:isLocaleEn(context)? null:10,
                        top: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child:
                            GestureDetector(
                              onTap:  () => controller.removeProduct(product.id),
                              child: TRoundedContainer(
                                                    width: 30,
                                                    height: 30,
                                                    radius: BorderRadius
                                                        .circular(40),
                                                    backgroundColor:
                                                        TColors.black
                                                            .withValues(
                                                                alpha:
                                                                    .5),
                                                    child: const Icon(
                                                      Icons.close_rounded,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                            ),
                            
                         
                          ),
                        ),
                      ),
                    ],
                  );
                  // ListTile(
                  //   title: Text(
                  //       isLocaleEn(context) ? product.title : product.arabicTitle),
                  //   subtitle: Text("\AED ${product.price}"),
                  //   leading: TRoundedContainer(
                  //     width: 60,
                  //     height: 80,
                  //     radius: BorderRadius.circular(15),
                  //     child: CustomCaChedNetworkImage(
                  //       url: product.images!.first,
                  //       width: 60,
                  //       height: 80,
                  //       raduis: BorderRadius.circular(15),
                  //     ),
                  //   ),
                  //   trailing: IconButton(
                  //     icon: Icon(Icons.delete),
                  //     onPressed: () => controller.removeProduct(product.id),
                  //   ),
                  // );
                },
              ),
            )),
      ),
    );
  }
}
