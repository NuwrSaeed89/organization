import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/all_products_grid.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/favorite_widget.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/saved_widget.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu_product.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar_client.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/social/presentation/widgets/posts/network/display/display_image_full.dart';
import 'package:readmore/readmore.dart';

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
    bool edit = false;
    if (vendorId == FirebaseAuth.instance.currentUser!.uid) {
      edit = true;
    }
    // ScrollController scrollController = ScrollController();
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBarClient(
            title: isArabicLocale() ? product.arabicTitle : product.title),
        // appBar: const CustomAppBar(title: 'product_details'),
        body: RefreshIndicator(
            onRefresh: () async {
              ProductRepository.instance.getAllProducts(vendorId);
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  //ProductImageView(productModel: product),

                  if (product.images!.isNotEmpty)
                    SizedBox(
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
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 50.w,
                            child: ReadMoreText(
                              isArabicLocale()
                                  ? product.arabicTitle
                                  : product.title,
                              trimLines: 2,
                              style: titilliumBold.copyWith(fontSize: 20),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SavedButton(product: product),
                              SizedBox(
                                width: 8,
                              ),
                              FavouriteButton(
                                editMode: true,
                              ),
                              Visibility(
                                visible: edit,
                                child: ControlPanelProduct(
                                    vendorId: vendorId, product: product),
                              ),
                            ],
                          ),
                        ]),
                  ),

                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: SizedBox(
                      width: 80.w,
                      child: ReadMoreText(
                        isLocaleEn(context)
                            ? product.description ?? ''
                            : product.arabicDescription ?? '',
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
                  ),

                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: TSizes.defaultSpace),
                    child: Row(
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
                                      fontSize: 15)),
                        const SizedBox(width: 10),
                        Text("${product.salePrice} AED",
                            // PriceConverter.convertPrice(context, product.unitPrice,
                            //     discountType: product.discountType,
                            //     discount: product.discount),
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontFamily: englishFonts,
                                    fontSize: 17,
                                    color: TColors.primary)),
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
                    height: TSizes.spaceBtWsections,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtWsections,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtWsections * 2,
                  ),
                  TCustomWidgets.buildTitle(isArabicLocale()
                      ? 'ربما يعجبك هذا'
                      : 'More From This Shop'),
                  TCustomWidgets.buildDivider(),
                  ProductTableGrid(vendorId: vendorId),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),

              // : const ProductDetailsShimmer(),
            )),
      ),
    );
  }
}
