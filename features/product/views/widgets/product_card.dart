// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:winto/core/functions/lang_f.dart';
// import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
// import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/styles/shadows.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/widgets/images/rounded_image.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/widgets/texts/product_price_text.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/widgets/texts/product_title_text.dart';
// import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
// import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
// import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

// class TProductCardHorizontal extends StatelessWidget {
//   const TProductCardHorizontal(
//       {super.key, required this.product, required int index});
//   final ProductModel product;
//   @override
//   Widget build(BuildContext context) {
//     var dark = false; //THelperFunctions.isDarkMode(context);
//     //final isEg = Get.locale?.languageCode == 'en';
//     final controller = ProductController.instance;
//     final salePrecentage =
//         controller.calculateSalePresentage(product.price, product.oldPrice);

//     return GestureDetector(
//       onTap: () {},
//       //  =>
//       // Get.to(() => ProductDetailsScreen(product: product)),
//       child: Container(
//         //  width: 200,
//         // height: 300,
//         // padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//             boxShadow: [TShadowStyle.verticalProductShadow],
//             color: dark ? TColors.dark.withOpacity(0.5) : TColors.white,
//             borderRadius: BorderRadius.circular(TSizes.productImageRadius)),
//         child: SizedBox(
//           height: 300,
//           width: 220,
//           child: Column(
//             children: [
//               TRoundedImage(
//                   imageUrl: product.images!.first,
//                   fit: BoxFit.fitWidth,
//                   width: 220,
//                   height: 150,
//                   imageType: ImageType.network,
//                   borderRaduis:
//                       BorderRadius.circular(TSizes.productImageRadius)),
//               //   productPhoto(
//               //       product: product, s: s, salePrecentage: salePrecentage),
//               // ),

//               //details section
//               const SizedBox(height: TSizes.md),

//               Padding(
//                 padding:
//                     const EdgeInsets.only(left: TSizes.sm, right: TSizes.sm),
//                 child: Column(
//                   children: [
//                     TProductTitleText(
//                       title: Get.locale?.languageCode == 'en'
//                           ? product.title
//                           : product.arabicTitle,
//                       txtAlign: Get.locale?.languageCode == 'en'
//                           ? TextAlign.left
//                           : TextAlign.right,
//                       smalSize: true,
//                     ),
//                     // const SizedBox(height: TSizes.spaceBtWItems / 2),
//                     //TBrandTitleWithVerifiedIcon(title: product.brand!.name),

//                     //price row
//                   ],
//                 ),
//               ),
//               const Spacer(),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Flexible(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: !isArabicLocale()
//                               ? const EdgeInsets.only(left: TSizes.sm)
//                               : const EdgeInsets.only(right: TSizes.sm),
//                           child: TProductPriceText(
//                             price: controller.getProductPrice(product),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   // ProductAddToCartButton(product: product)
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
