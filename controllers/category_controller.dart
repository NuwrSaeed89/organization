import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/data/repositories/category_repository.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/loaders.dart';
import 'package:winto/features/organization/e_commerce/utils/logging/logger.dart';

import '../features/category/view/create_category/widget/create_category_form.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allItems = <CategoryModel>[].obs;
  RxList<CategoryModel> featureCategories = <CategoryModel>[].obs;
  final searchTextController = TextEditingController();
  RxList<CategoryModel> felteredItems = <CategoryModel>[].obs;
  RxBool refreshData = true.obs;
  List<CategoryModel> categoryList = [];

  final categoryName = TextEditingController();
  final categoryArabicName = TextEditingController();
  final categoryImage = TextEditingController();
  RxString storeId =''.obs;
@override
void onInit() {
  ever(storeId, (id) =>   fetchCategoryData());
  super.onInit();
}

 
  var load = false.obs;
  Future<List<CategoryModel>> getCategoryOfUser(String userId) async {
    load(true);
   var s=  await categoryRepository.getAllCategoriesUserId(userId);
     allItems.value=s;
    load(false);
    return allItems;
    // .where((cat) => cat.parentId.isEmpty)
    // .take(8)
    // .toList();
  }

  Future<void> fetchCategoryData() async {
    try {
      isLoading.value = true;
      List<CategoryModel> fetchedItem = [];
      if (allItems.isEmpty) {
        fetchedItem = await categoryRepository.getAllCategories();
      }
      allItems.value = fetchedItem;
      featureCategories.assignAll(allItems
          .where((cat) => cat.isFeature! && cat.parentId.isEmpty)
          .take(8)
          .toList());
      felteredItems.value = allItems;
      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      isLoading.value = false;
      // Get.snackbar('oh Snap!', e.toString());
    }
  }

  void addItemToLists(CategoryModel item) {
    allItems.add(item);
    felteredItems.add(item);
  }

  void updateItemFromLists(CategoryModel item) {
    final index = allItems.indexWhere((i) => i == item);
    if (index != -1) allItems[index] = item;

    final indexFilt = felteredItems.indexWhere((i) => i == item);
    if (indexFilt != -1) felteredItems[indexFilt] = item;
    felteredItems.refresh();
  }

  void removeItemFromLists(CategoryModel item) {
    allItems.remove(item);
    if (item.isFeature!) featureCategories.remove(item);
    felteredItems.remove(item);
  }

  Future<List<CategoryModel>> getSubCategories(
      String categoryId, String userId) async {
    try {
      final subCategories =
          await categoryRepository.getSubCategories(categoryId, userId);
      return subCategories;
    } catch (e) {
      return [];
    }
  }

  bool selectedItem = true;

  RxString selectedValue = ''.obs;

  Future<dynamic> addNewCategory(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SizedBox(
              height: 3000,
              child: SingleChildScrollView(
                child: CreateCategoryForm(),
              ),
            ));
  }

  void resetFormField() {
    categoryName.clear();
    categoryImage.clear();
    categoryArabicName.clear();
  }

  void uploadCategoryPhoto() async {}

  void deleteCategory(String categoryId) async {
    TLoggerHelper.info("============id ============================");
    TLoggerHelper.info(categoryId);
    if (await showExitDialog()) {
      final docCategory =
          FirebaseFirestore.instance.collection('Categories').doc(categoryId);
      docCategory.delete();
      TLoader.successSnackBar(title: "successfully", message: "تم الحذف بنجاح");
    }
  }

  Future<bool> showExitDialog() async {
    return await showDialog(
        context: Get.context!,
        builder: (context) => AlertDialog(
              title: Text(
                "حذف",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              content: Text("هل أنت متأكد من حذف الفئة",
                  style: Theme.of(context).textTheme.bodyMedium),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "لا",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      "نعم",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: Colors.white),
                    ))
              ],
            ));
  }

  Future addCategory(CategoryModel newCat) async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    if (userId.isEmpty) {
      throw 'Unable to find user information. try again later';
    }
    var docCategory = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('organization')
        .doc('1')
        .collection('category')
        .add(newCat.toJson());
    newCat.id = docCategory.id;
    final json = newCat.toJson();
    await docCategory.set(json);
    //  isLoading.value = false;
    //LoadingFullscreen.stopLoading();

    TLoader.successSnackBar(
        title: "Successfull", message: "تـمت الاضافة بنجاح");

    resetFormField();
    CategoryController.instance.addItemToLists(newCat);
    //fetchData();
  }

  RxList<ProductModel> all = <ProductModel>[].obs;
  RxList<ProductModel> filteredItem = <ProductModel>[].obs;
  Future<List<ProductModel>> getCategoryProduct(
      {required String categoryId,
    
      required String userId}) async {
    final product = await ProductRepository.instance.getProductsForCategory(
        categoryId: categoryId, vendorId: userId);
    all.assignAll(product);
    filteredItem.assignAll(all);
    return product;
  }

  searchQuery(String query) {
    filteredItem.assignAll(all.where((item) =>
        item.arabicTitle.toLowerCase().contains(query.trim().toLowerCase()) ||
        item.title.toLowerCase().contains(query.trim().toLowerCase())));
  }
}
