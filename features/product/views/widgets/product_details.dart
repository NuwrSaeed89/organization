import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/favorite_widget.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_image_slider_details.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/slider_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/category_product_grid.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu_product.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/social/presentation/widgets/posts/network/display/display_image_full.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel product;
  final String vendorId;
  final bool isEditable;
  ProductDetails(
      {super.key,
      required this.product,
      this.isEditable = false,
      required this.vendorId});

  RxBool isReview = false.obs;
  @override
  Widget build(BuildContext context) {
       var oldPrice=product.oldPrice??0;
      var controller=Get.put(SliderController());
    bool edit = false;
    if (vendorId == FirebaseAuth.instance.currentUser!.uid) {
      edit = true;
    }
    // ScrollController scrollController = ScrollController();
    return  Scaffold(
    
       body:SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: AnimatedOpacity(
          duration: Duration(microseconds: 500),
          opacity: 1.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
             
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  children: [
                   IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon( Icons.arrow_back_ios_new_rounded,
                       size: 18,)),
                      if (product.images!.length > 1)  Expanded(
                      child: TRoundedContainer(
                       
                                        backgroundColor: Colors.transparent,
                        width: 40,
                        height: 30,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Obx(()=> Text('${controller.selectdindex.value+1}/${product.images!.length}')),
                          ),
                        ),),
                    ),
                    SizedBox(width: 30,)
                  ],
                ),
              ),
              
              //ProductImageView(productModel: product),
                
                Stack(
          alignment: Alignment.topCenter,
          children: [
            
            TProductImageSliderDetails(product:product,prefferHeight:100.w*(8/6) ,prefferWidth: 100.w,radius: BorderRadius.circular(0), ),
                
                 
          ],
                )
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: CustomSlider(images:product.images! ,prefferHeight: 120.w,
          //                         prefferWidth: 98.w, autoPlay: false,),
          // ),
            ,
            
                Visibility(
                  visible: false,
                  child: SizedBox(
                    height: 65.h,
                    child: ListView.builder(
                      // padding: EdgeInsets.symmetric(vertical: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: isArabicLocale()
                              ? EdgeInsets.only(
                                  right: 3.5.w,
                                  bottom: 16,
                                  left: index == product.images!.length - 1
                                      ? 3.5.w
                                      : 0)
                              : EdgeInsets.only(
                                  left: 3.5.w,
                                  bottom: 16,
                                  right: index == product.images!.length - 1
                                      ? 3.5.w
                                      : 0),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 65.h,
                                width: 93.w,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                NetworkImageContainerFullSize(
                                                    product.images![index])));
                                  },
                                  child: CustomCaChedNetworkImage(
                                    url: product.images![index],
                                    width: 100.w,
                                    height: 65.h,
                                    raduis: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: product.images!.length > 1,
                                child: Positioned(
                                  bottom: 16,
                                  right: 16,
                                  child: TRoundedContainer(
                                    backgroundColor: TColors.white,
                                    radius: BorderRadius.circular(50),
                                    padding: EdgeInsets.all(8),
                                    child: Center(
                                      child: Text(
                                        '${index + 1}/${product.images!.length}',
                                        style: titilliumBold.copyWith(
                                            color: Colors.black,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
            //  const SizedBox(height: 10),
              Padding(
                   padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                       
                          children: [
                            Visibility(
                              visible: edit,
                              child: ControlPanelProduct(
                              
                                  vendorId: vendorId, product: product),
                            ),
                Visibility(
                  visible: !edit,
                  child: SizedBox(
                                width: 8,
                              ),
                ),
                             FavouriteButton(
                              withBackground:false,
                              editMode: true,
                              size: 25,
                            ),
                           
                            SizedBox(
                              width: 3,
                            ),
                            SavedButton(
                              size: 24,
                             // withBackground:false,
                              product: product),
                            
                          ],
                        ),
              ),
                       const SizedBox(height: 16),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80.w,
                        child: ReadMoreText(
                          isLocaleEn(context) ?  product.title.isEmpty?  product.arabicTitle :product.title :  product.arabicTitle.isEmpty? product.title   : product.arabicTitle,
                          trimLines: 2,
                          style: titilliumBold.copyWith(fontSize: 18,fontWeight:FontWeight.w700),
                          trimMode: TrimMode.Line,
                          trimCollapsedText:
                              isLocaleEn(context) ? 'more' : 'المزيد',
                          trimExpandedText:
                              isLocaleEn(context) ? 'less' : 'أقل',
                          moreStyle: robotoHintRegular.copyWith(
                              color: Colors.black),
                          lessStyle: robotoHintRegular.copyWith(
                              color: Colors.black),
                        ),
                      ),
                      
                    ]),
              ),
            const SizedBox(height: 10),
            
              Padding(
               padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: ReadMoreText(
                  isLocaleEn(context) ?  product.description ??product.arabicDescription??"" :product.arabicDescription??product.description??"",
                  trimLines: 2,
                  style: robotoRegular.copyWith(fontSize: 16),
                  trimMode: TrimMode.Line,
                  trimCollapsedText:
                      isLocaleEn(context) ? 'more' : 'المزيد',
                  trimExpandedText: isLocaleEn(context) ? 'less' : ' أقل',
                  moreStyle:
                      robotoHintRegular.copyWith(color: Colors.black),
                  lessStyle:
                      robotoHintRegular.copyWith(color: Colors.black),
                ),
              ),
            const SizedBox(height: 8),
              const SizedBox(height: 8),
              Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Row(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     if (product.oldPrice !=null)

                 
                      Align(
                  alignment: Alignment.bottomCenter,child: TCustomWidgets.viewSalePrice(oldPrice.toString(),15)),
                      SizedBox(width: 6),
                     TCustomWidgets.formattedPrice( product.price,'AED',20)
                  ],
                ),
              ),
              const SizedBox(height: 4),
              // Padding(
              //     padding: const EdgeInsets.only(bottom: 0),
              //     child: Text("تبقى منه  ${product.stock}  ",
              //         style: robotoMedium.copyWith(
              //             color: TColors.primary))),
                
              const SizedBox(
                height: TSizes.spaceBtWsections*2,
              ),
             
              // const SizedBox(
              //   height: TSizes.spaceBtWsections * 2,
              // ),
              TCustomWidgets.buildTitle(isArabicLocale()
                  ? 'ربما يعجبك هذا'
                  : 'More From This Shop'),
              TCustomWidgets.buildDivider(),
                
              TCategoryProductGrid(product: product,editMode: edit,userId: vendorId,),
             // ProductTableGrid(vendorId: vendorId),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      
        // : const ProductDetailsShimmer(),
      ),
      ),
    );
  }
}
