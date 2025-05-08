// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:get/get.dart';
// import 'package:winto/app/app_localization.dart';
// import 'package:winto/core/functions/lang_f.dart';
// import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
// import 'package:winto/features/organization/e_commerce/features/banner/view/front/promo_slider.dart';
// import 'package:winto/features/organization/e_commerce/features/category/view/all_category/widgets/category_grid_item.dart';
// import 'package:winto/features/organization/e_commerce/features/category/view/create_category/create_category.dart';
// import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
// import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
// import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_larg.dart';
// import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_medium.dart';
// import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_simpleLarge.dart';
// import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_widget_small.dart';
// import 'package:winto/features/organization/e_commerce/features/shop/controller/profile_controller.dart';

// import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/market_header.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
// import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
// import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

// class MyECommerceShop extends StatelessWidget {
//   const MyECommerceShop(
//       {super.key, required this.vendorId, required this.editMode});
//   final String vendorId;
//   final bool editMode;
//   @override
//   Widget build(BuildContext context) {
//     final controller = ProfileController.instance;
//     var user = controller.profilData;
//     var categories = CategoryController.instance.allItems;
//     List<ProductModel> featureProduct = [];
//     List<ProductModel> saleProduct = ProductController.instance.saleProduct;
//     featureProduct.assignAll(ProductController.instance.allItems
//         .where((p0) => p0.isFeature == true));

//     return SafeArea(
//       child: Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             // SliverAppBar(
//             //     automaticallyImplyLeading: false,
//             //     primary: false,
//             //     forceMaterialTransparency: false,
//             //     expandedHeight: 60,
//             //     floating: false,
//             //     backgroundColor: TColors.white,
//             //     pinned: false,
//             //     flexibleSpace: FlexibleSpaceBar(
//             //       background: Padding(
//             //         padding: EdgeInsets.only(left: 4.0, right: 4, top: 16),
//             //         child: SvgPicture.asset(
//             //           'assets/svg/winto.svg', //assets\svg\winto.svg
//             //         ),
//             //         //  AssetImage(
//             //         //   TImages.lightAppLogo,
//             //         // ),
//             //       ),
//             //     )),

//             // CustomShopAppbar(
//             //     title: user.organizationName,
//             //     imageLeading: Padding(
//             //       padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4),
//             //       child: UserProfileImageWidget(
//             //           imgUrl: user.profileImage,
//             //           size: 60,
//             //           withShadow: false,
//             //           allowChange: true),
//             //     )),

//             SliverToBoxAdapter(
//               child: marketHeaderSection(vendorId, true),
//             ),
//             // TopSection(
//             //   productCount: featureProduct.length,
//             // ),

//             SliverAppBar(
//               automaticallyImplyLeading: false,
//               primary: false,
//               forceMaterialTransparency: false,
//               //expandedHeight: 160,
//               toolbarHeight: 160,
//               floating: true,
//               elevation: .4,
//               backgroundColor: TColors.white,
//               pinned: false,
//               flexibleSpace: FlexibleSpaceBar(
//                 background: Padding(
//                   padding: const EdgeInsets.only(top: TSizes.appBarHeight / 2),
//                   child: (categories.length > 0)
//                       ? ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: categories.length,
//                           itemBuilder: (context, index) {
//                             return TCategoryGridItem(
//                                 editMode: true,
//                                 category: categories[index],
//                                 vendorId: vendorId);
//                           },
//                         )
//                       : editMode
//                           ? Stack(
//                               alignment: Alignment.center,
//                               children: [
//                                 const TShimmerEffect(width: 120, height: 50),
//                                 InkWell(
//                                   onTap: () => Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const CreateCategory(
//                                                   // suggestingCategory:
//                                                   //     category,
//                                                   ))),
//                                   child: Column(
//                                     children: [
//                                       const SizedBox(
//                                         child: Icon(Icons.add),
//                                       ),
//                                       SizedBox(
//                                         child: Text(
//                                           isArabicLocale()
//                                               ? 'اضافة فئة '
//                                               : 'Add Category',
//                                           style: titilliumBold,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             )
//                           : const SizedBox(),
//                 ),
//               ),
//             ),
//             SliverToBoxAdapter(
//               child: TPromoSlider(
//                 vendorId: vendorId,
//               ),
//             ),
//             const SliverToBoxAdapter(
//               child: SizedBox(
//                 height: 8,
//               ),
//             ),
//             if (featureProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                   child: buildTitle(AppLocalizations.of(context)
//                       .translate('shop.featurdProducts'))),
//             if (featureProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 0, right: 0, top: 20),
//                   child: SizedBox(
//                     height: 280,
//                     child: ListView.builder(
//                         // separatorBuilder: (context, index) =>
//                         //     const SizedBox(width: 10),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: featureProduct.length,
//                         itemBuilder: (_, index) => Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: SizedBox(
//                                 height: 270,
//                                 width: 120,
//                                 child: ProductWidgetSmall(
//                                   vendorId: vendorId,
//                                   product: featureProduct[index],
//                                 ),
//                               ),
//                             )),
//                   ),
//                 ),
//               ),
//             if (featureProduct.isNotEmpty)
//               const SliverToBoxAdapter(
//                 child: Divider(),
//               ),
//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                   child: buildTitle(isLocaleEn(context) ? 'Sales' : 'تنزيلات')),
//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 250,
//                   child: ListView.builder(
//                       // separatorBuilder: (context, index) =>
//                       //     const SizedBox(width: 10),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: featureProduct.length,
//                       itemBuilder: (_, index) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 5),
//                             child: SizedBox(
//                               height: 270,
//                               width: 120,
//                               child: ProductWidgetSmall(
//                                 vendorId: vendorId,
//                                 product: featureProduct[index],
//                               ),
//                             ),
//                           )),
//                 ),
//               ),
//             if (saleProduct.isNotEmpty)
//               const SliverToBoxAdapter(
//                 child: Divider(),
//               ),
//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                   child: buildTitle(
//                       isLocaleEn(context) ? 'We Choose for you' : 'اخترنا لك')),
//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 270,
//                   child: ListView.builder(
//                       // separatorBuilder: (context, index) =>
//                       //     const SizedBox(width: 10),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: featureProduct.length,
//                       itemBuilder: (_, index) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 5),
//                             child: SizedBox(
//                               height: 270,
//                               width: 120,
//                               child: ProductWidgetSmall(
//                                 vendorId: vendorId,
//                                 product: featureProduct[index],
//                               ),
//                             ),
//                           )),
//                 ),
//               ),
//             if (saleProduct.isNotEmpty)
//               const SliverToBoxAdapter(
//                 child: Divider(),
//               ),
//             if (featureProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                   child: buildTitle(
//                       AppLocalizations.of(context).translate('shop.offers'))),
//             if (featureProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   child: SizedBox(
//                     height: 370,
//                     child: ListView.builder(
//                         // separatorBuilder: (context, index) =>
//                         //     const SizedBox(width: 10),
//                         scrollDirection: Axis.horizontal,
//                         itemCount: featureProduct.length,
//                         itemBuilder: (_, index) => Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 5),
//                               child: SizedBox(
//                                 width: 200,
//                                 child: ProductWidgetSmall2(
//                                   product: featureProduct[index],
//                                 ),
//                               ),
//                             )),
//                   ),
//                 ),
//               ),
//             if (featureProduct.isNotEmpty)
//               const SliverToBoxAdapter(
//                 child: Divider(),
//               ),

//             // SliverToBoxAdapter(
//             //   child: Padding(
//             //       padding: const EdgeInsets.all(16.0),
//             //       child: MasonryGridView.count(
//             //         itemCount: featureProduct.length,
//             //         crossAxisCount: 3,
//             //         mainAxisSpacing: 6,
//             //         crossAxisSpacing: 6,
//             //         padding: const EdgeInsets.all(0),
//             //         physics: const NeverScrollableScrollPhysics(),
//             //         shrinkWrap: true,
//             //         itemBuilder: (BuildContext context, int index) {
//             //           return ProductWidgetSmall(
//             //             product: featureProduct[index],
//             //           );
//             //         },
//             //       )),
//             // ),
//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                   child: buildTitle(
//                       isArabicLocale() ? 'وصلنا حديثا' : 'New Arrival')),
//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: MasonryGridView.count(
//                       itemCount: saleProduct.length,
//                       crossAxisCount: 2,
//                       mainAxisSpacing: 10,
//                       crossAxisSpacing: 10,
//                       padding: const EdgeInsets.all(0),
//                       physics: const NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (BuildContext context, int index) {
//                         return SizedBox(
//                           height: 290,
//                           child: ProductWidgetMedium(
//                             editMode: editMode,
//                             vendorId: vendorId,
//                             product: saleProduct[index],
//                           ),
//                         );
//                       },
//                     )),
//               ),
//             if (saleProduct.isNotEmpty)
//               const SliverToBoxAdapter(
//                 child: Divider(),
//               ),

//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: buildTitle(
//                     isArabicLocale() ? 'الأكثر طلبا' : 'Trend Items'),
//               ),
//             if (saleProduct.isNotEmpty)
//               SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 440,
//                   child: ListView.builder(
//                       // separatorBuilder: (context, index) =>
//                       //     const SizedBox(width: 10),
//                       scrollDirection: Axis.horizontal,
//                       itemCount: saleProduct.length,
//                       itemBuilder: (_, index) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 5),
//                             child: SizedBox(
//                               width: 290,
//                               child: ProductWidgetLarg(
//                                 vendorId: vendorId,
//                                 product: saleProduct[index],
//                               ),
//                             ),
//                           )),
//                 ),
//               ),
//             if (saleProduct.isNotEmpty)
//               const SliverToBoxAdapter(
//                 child: SizedBox(
//                   height: 100,
//                 ),
//               ),
//             // SliverToBoxAdapter(
//             //   child: branches(userId, true, context),
//             // ),
//             // const SliverFillRemaining(
//             //   hasScrollBody: false,
//             //   child: Column(
//             //     children: [
//             //       SizedBox(height: 100),
//             //       Padding(
//             //         padding: EdgeInsets.symmetric(vertical: 25.0),
//             //         child: Center(
//             //           child: Row(
//             //             mainAxisSize: MainAxisSize.min,
//             //             children: [
//             //               //  Text('Powered by iwinto'),

//             //               Image(image: AssetImage(TImages.logo))
//             //             ],
//             //           ),
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // )
//           ],
//           // child: Column(
//           //   children: [
//           //     Text(data.facebook),
//           //     Text(data.organizationName),
//           //     Text(data.website),
//           //     SizedBox(
//           //         width: 200,
//           //         height: 300,
//           //         child: Image.network(data.profileImage)),
//           //     Text('5'),
//           //     Text('6'),
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }

//   Padding buildTitle(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
//       child: Text(
//         text,
//         style: titilliumBold.copyWith(fontSize: 20),
//       ),
//     );
//   }
// }

// class CustomShopAppbar extends StatelessWidget {
//   const CustomShopAppbar(
//       {super.key, required this.title, required this.imageLeading});

//   final String title;
//   final Widget imageLeading;

//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       centerTitle: true,
//       toolbarHeight: 65,
//       floating: false,
//       iconTheme: const IconThemeData(color: TColors.black),
//       pinned: false,
//       actions: [
//         Padding(padding: const EdgeInsets.all(8), child: imageLeading
//             //  Image.asset(
//             //   TImages.logo,
//             //   width: 50,
//             // ),
//             )
//       ],
//       backgroundColor: TColors.white,
//       title: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Text(
//           title,
//           style: titilliumSemiBold.copyWith(color: TColors.black, fontSize: 20),
//         ),
//       ),
//     );
//   }
// }
