import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/controllers/edit_category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/repositories/auth_init_repository.dart';
import 'package:winto/features/organization/e_commerce/features/banner/controller/banner_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/profile_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/http/network.dart';
import 'package:winto/features/organization/e_commerce/data/repositories/category_repository.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() async {
    // Order matters
    Get.put(NetworkManager());

    final authInitRepo = await Get.putAsync(() => AuthInitRepository().init());

    // Register repository first
    Get.put(CategoryRepository());

    // Then register controllers
    Get.put(CategoryController());
    Get.put(BannerController());
    Get.put(ProductController());
    Get.put(EditProductController());
    Get.put(ProfileController());
    Get.put(EditCategoryController());
    Get.put(SavedProductsController());
  }
}
