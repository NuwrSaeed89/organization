// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:sizer/sizer.dart';
// import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
// import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
// import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
// import 'package:winto/features/organization/e_commerce/features/shop/controller/profile_controller.dart';
// import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/branch.dart';
// import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/branch_view.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/appbar.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
// import 'package:winto/features/organization/e_commerce/utils/common/widgets/images/circular_image.dart';
// import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
// import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
// import 'package:winto/features/organization/e_commerce/utils/helpers/helper_functions.dart';

// class TShopHome2 extends StatelessWidget {
//   const TShopHome2({super.key, required this.userId});
//   final String userId;
//   @override
//   Widget build(BuildContext context) {
//     var user = ProfileController.instance.profilData;
//     var categories = CategoryController.instance.allItems;
//     List<ProductModel> featureProduct = [];
//     List<ProductModel> saleProduct = ProductController.instance.saleProduct;
//     featureProduct.assignAll(ProductController.instance.allItems
//         .where((p0) => p0.isFeature == true));

//     return Scaffold(
//         appBar: CustomAppBar(title: user.organizationName),
//         body: SafeArea(child: branchesView(userId, true, context)));
//   }
// }
