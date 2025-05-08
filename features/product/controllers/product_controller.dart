import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/constants/app_urls.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/core/utils/uploads.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  //Variables
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  List<ProductModel> saleProduct = [];
  final RxList<ProductModel> allItems = <ProductModel>[].obs;
  final RxList<ProductModel> productCategory = <ProductModel>[].obs;
  final title = TextEditingController();
  final arabicTitle = TextEditingController();
  final description = TextEditingController();
  final arabicDescription = TextEditingController();
  final price = TextEditingController();
  final salePrice = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CategoryModel category = CategoryModel.empty();
  RxList<String> images = <String>[].obs;
  RxString message = ''.obs;
  final searchTextController = TextEditingController();
  Future<void> createProduct(String type, String vendorId) async {
    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
      Navigator.pop(Get.context!);
      return;
    }
    if (selectedImage.isEmpty) {
      isLoading.value = false;
      TLoader.warningSnackBar(
          title: isArabicLocale() ? 'تحذير' : 'Warning',
          message: isArabicLocale()
              ? "يرجى ادخال صورة على الأقل"
              : "Please add at least one photo");
      Navigator.pop(Get.context!);
      return;
    } else if (category == CategoryModel.empty()) {
      isLoading.value = false;
      TLoader.warningSnackBar(
          title: isArabicLocale() ? 'تحذير' : 'Warning',
          message: isArabicLocale()
              ? "يرجى اختيار تصنيف "
              : "Please select a category");
      Navigator.pop(Get.context!);
      return;
    } else {
      message.value =
          isArabicLocale() ? "جاري رفع الصور" : "uploading product images ..";
      images.value = await uploadImages(selectedImage);
      message.value = isArabicLocale() ? "جاري ارسال البيانات" : "send data ..";
      final product = ProductModel(
        id: '',
        vendorId: vendorId,
        title: title.text.trim(),
        arabicTitle: arabicTitle.text.trim(),
        price: double.parse(price.text.toString()),
        salePrice: double.parse(salePrice.text.toString()),
        description: description.text.trim(),
        arabicDescription: arabicDescription.text.trim(),
        images: images,
        isFeature: true,
        category: category,
        productType: type,
      );
      try {
        if (vendorId.isEmpty) {
          throw 'Unable to find user information. try again later';
        }
        message.value = isArabicLocale() ? "ارسال البيانات" : "send data..";
        await productRepository.addProducts(product, vendorId);
        message.value = "evry thing done";
        allItems.add(product);
        if (type == 'offers') offerDynamic.add(product);
        if (type == 'all') allDynamic.add(product);
        if (type == 'all1') allLine1Dynamic.add(product);
        if (type == 'all2') allLine2Dynamic.add(product);
        if (type == 'sales') salesDynamic.add(product);
        if (type == 'foryou') foryouDynamic.add(product);
        if (type == 'mixone') mixoneDynamic.add(product);
        if (type == 'mixline1') mixline1Dynamic.add(product);
        if (type == 'mixline2') mixline2Dynamic.add(product);
        if (type == 'mostdeamand') mostdeamandDynamic.add(product);
        if (type == 'newArrival') newArrivalDynamic.add(product);
        resetFields();
        message.value = "";
        selectedImage.value = [];
        TLoader.successSnackBar(
            title: isArabicLocale() ? 'نجاح' : 'Successfull',
            message: isArabicLocale()
                ? "تم الادخال بنجاح"
                : "data insert successfully");
      } catch (e) {
        throw 'some thing go wrong while add category';
      }
    }
  }

  Future<int> getUserProductCount(String userId) async {
    var productCount = productRepository.getUserProductCount(userId);
    return productCount; // عدد المنتجات الخاصة بالمستخدم
  }

  void resetFields() {
    isLoading(false);
    title.clear();
    arabicTitle.clear();
    description.clear();
    arabicDescription.clear();
    price.clear();
    salePrice.clear();
    selectedImage.value = [];
  }

  Future<void> fetchdata(String vendorId) async {
    try {
      var fetchedItem = await productRepository.getAllProducts(vendorId);

      allItems.value = fetchedItem;
      saleProduct = getSaleProduct();
      if (kDebugMode) {
        print("============product length ${allItems.length}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  RxList<ProductModel> offerDynamic = <ProductModel>[].obs;
  RxList<ProductModel> allDynamic = <ProductModel>[].obs;
  RxList<ProductModel> allLine1Dynamic = <ProductModel>[].obs;
  RxList<ProductModel> allLine2Dynamic = <ProductModel>[].obs;
  RxList<ProductModel> salesDynamic = <ProductModel>[].obs;
  RxList<ProductModel> foryouDynamic = <ProductModel>[].obs;
  RxList<ProductModel> mixoneDynamic = <ProductModel>[].obs;
  RxList<ProductModel> mixline1Dynamic = <ProductModel>[].obs;
  RxList<ProductModel> mixline2Dynamic = <ProductModel>[].obs; //Most Demanded
  RxList<ProductModel> mostdeamandDynamic = <ProductModel>[].obs;
  RxList<ProductModel> newArrivalDynamic = <ProductModel>[].obs;
  RxList<ProductModel> fetchedTypeItem = <ProductModel>[].obs;
  var lastDocument;

  void fetchOffersData(String vendorId, String type) async {
    isLoading.value = true;
    try {
      var fetchedItem =
          await productRepository.getProductsbyType(vendorId, type);
      // featureCategories.assignAll(fetchedItem
      //     .where((cat) => cat.isFeature! && cat.parentId.isEmpty)
      //     .take(8)
      //     .toList());
      if (type == 'offers') offerDynamic.value = fetchedItem;
      if (type == 'all') allDynamic.value = fetchedItem;
      if (type == 'all1') allLine1Dynamic.value = fetchedItem;
      if (type == 'all2') allLine2Dynamic.value = fetchedItem;
      if (type == 'sales') salesDynamic.value = fetchedItem;
      if (type == 'foryou') foryouDynamic.value = fetchedItem;
      if (type == 'mixone') mixoneDynamic.value = fetchedItem;
      if (type == 'mostdeamand') mixoneDynamic.value = fetchedItem;
      if (type == 'mixlin1') mixline1Dynamic.value = fetchedItem;
      if (type == 'mixlin2') mixline2Dynamic.value = fetchedItem;
      if (type == 'newArrival')
        newArrivalDynamic.value = fetchedItem; //newArrival
      isLoading.value = false;
     
    } catch (e) {
      if (kDebugMode) {
        print(e);
        isLoading.value = false;
      }
    }
  }

  Future<List<ProductModel>> fetchListData(String vendorId, String type) async {
    try {
      var fetchedItem =
          await productRepository.getProductsbyType(vendorId, type);
      // featureCategories.assignAll(fetchedItem
      //     .where((cat) => cat.isFeature! && cat.parentId.isEmpty)
      //     .take(8)
      //     .toList());
      if (type == 'offers') offerDynamic.value = fetchedItem;
      if (type == 'all') allDynamic.value = fetchedItem;
      if (type == 'all1') allLine1Dynamic.value = fetchedItem;
      if (type == 'all2') allLine2Dynamic.value = fetchedItem;
      if (type == 'sales') salesDynamic.value = fetchedItem;
      if (type == 'foryou') foryouDynamic.value = fetchedItem;
      if (type == 'mixone') mixoneDynamic.value = fetchedItem;
      if (type == 'mostdeamand') mixoneDynamic.value = fetchedItem;
      if (type == 'mixlin1') mixline1Dynamic.value = fetchedItem;
      if (type == 'mixlin2') mixline2Dynamic.value = fetchedItem;
      if (type == 'newArrival')
        newArrivalDynamic.value = fetchedItem; //newArrival

      fetchedTypeItem.value = fetchedItem;
      return fetchedItem;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        isLoading.value = false;
        return [];
      }
    }
    return [];
  }

  Future<void> fetchProductPageinations(
      String vendorId, String type, int limit) async {
    if (isLoading.value) return;

    isLoading(true);

    try {
      Query query = FirebaseFirestore.instance
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .where('ProductType', isEqualTo: type)
          //.orderBy('name')
          .limit(limit);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        List<ProductModel> products = querySnapshot.docs
            .map((doc) => ProductModel.fromQuerySnapshot(doc))
            .toList();

        //var newProducts = querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
        newArrivalDynamic.addAll(products);
      }
    } catch (e) {
      print('خطأ في جلب المنتجات: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<List<ProductModel>> fetchAllTypesData(
      String vendorId, String type) async {
    try {
      var fetchedItem = await productRepository.getFeaturesProducts(vendorId);
      allDynamic.value = fetchedItem;
      print('==========================${fetchedItem.length}==========len');
      allDynamic.value = fetchedItem;

      return fetchedItem;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        return [];
      }
      return [];
    }
  }

  Future<List<ProductModel>> fetchAllData(String vendorId) async {
    allItems.value = [];
    try {
      var allProduct = await productRepository.getAllProducts(vendorId);
      allItems.assignAll(allProduct);
      return allProduct;
    } catch (e) {
      if (kDebugMode) {
        print(e);
        return [];
      }
      return [];
    }
  }

  RxList<XFile> selectedImage = <XFile>[].obs;
  RxString localThumbnail = ''.obs;

  RxString thumbnailUrl = ''.obs;

  Future<void> pickImage() async {
    var pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle:
                AppLocalizations.of(Get.context!).translate('product.image'),
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: false,
          ),
          IOSUiSettings(
            title: AppLocalizations.of(Get.context!).translate('product.image'),
          ),
        ],
      );
      File img = File(croppedFile!.path);

      localThumbnail.value = img.path;
    }
  }

  Future<List<XFile>> selectImages() async {
    List<XFile> list = [];

    list = await ImagePicker().pickMultiImage();

    if (list.isNotEmpty) {
      selectedImage.addAll(list);

      return list;
    }
    return [];
  }

  Future<void> cropImage(String imagePath) async {
    var croppedFile = await ImageCropper().cropImage(
        sourcePath: imagePath,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: CropAspectRatio(ratioX: 600, ratioY: 800),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle:
                AppLocalizations.of(Get.context!).translate('product.image'),
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: AppLocalizations.of(Get.context!).translate('product.image'),
          )
        ]);

    if (croppedFile != null) {
      selectedImage.removeWhere((img) => img.path == imagePath);
      selectedImage.add(XFile(croppedFile.path));
    }
  }

  void takeCameraImages() async {
    var tackenImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (tackenImage != null) {
      selectedImage.add(tackenImage);
    }
  }

  Future<void> uploadThumbnail() async {
    message.value = "uploading img";
    if (localThumbnail.value == "") return;
    File img = File(localThumbnail.value);
    if (kDebugMode) {
      print("================= befor ==upload category=======");
      print(img.path);
    }
    var s = await uploadMediaToServer(img);
    thumbnailUrl.value = "$mediaPath$s";
    if (kDebugMode) {
      print("uploading url===${thumbnailUrl.value}");
      message.value = "uploading url====${thumbnailUrl.value} ";
    }
    return;
  }

  Future<List<String>> uploadImages(List<XFile> localImages) async {
    try {
      List<String> s3 = [];
      if (localImages == []) return s3;
      for (var image in localImages) {
        File img = File(image.path);

        var s = await uploadMediaToServer(img);

        s3.add("$mediaPath$s");
        if (kDebugMode) {
          print(
              "================= uploaded= compressed ========== $mediaPath$s");
        }
      }

      return s3;
    } catch (e) {
      if (kDebugMode) {
        print("=========Exception while upload $e");
      }

      return [];
    }
  }

  String getProductPrice(ProductModel product) {
    return " ${product.salePrice > 0 ? product.salePrice : product.price}";
  }

  String? calculateSalePresentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0 || originalPrice <= 0.0) {
      return null;
    }
    double precentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return precentage.toStringAsFixed(0);
  }

  // String getProductStockStatus(int stock) {
  //   return stock > 0 ? 'In Stock' : 'Out of Stock';
  // }

  double? getSaleNumber(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0 || originalPrice <= 0.0) {
      return 0;
    }
    double precentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return precentage;
  }

  List<ProductModel> getSaleProduct() {
    saleProduct = [];
    if (allItems == []) {
      return [];
    }

    for (final product in allItems) {
      if (getSaleNumber(product.price, product.salePrice)! > 0) {
        saleProduct.add(product);
      }
    }
    return saleProduct;
  }

  List<String> getAllProductImage(ProductModel product) {
    Set<String> images = {};
    if (product.thumbnail != '') images.add(product.thumbnail!);
    // selectedProductImage.value = product.thumbnail;
    if (product.images != null) {
      images.addAll(product.images!);
    }
    return images.toList();
  }

  Future<void> deleteProduct(ProductModel product, String vendorId) async {
    await productRepository.deleteProduct(product, vendorId);

    // categoryRepository.deleteCategory(category);
    allItems.remove(product);
    var type=product.productType!;
     if (type == 'offers') offerDynamic.remove(product);
        if (type == 'all') allDynamic.remove(product);
        if (type == 'all1') allLine1Dynamic.remove(product);
        if (type == 'all2') allLine2Dynamic.remove(product);
        if (type == 'sales') salesDynamic.remove(product);
        if (type == 'foryou') foryouDynamic.remove(product);
        if (type == 'mixone') mixoneDynamic.remove(product);
        if (type == 'mixline1') mixline1Dynamic.remove(product);
        if (type == 'mixline2') mixline2Dynamic.remove(product);
        if (type == 'mostdeamand') mostdeamandDynamic.remove(product);
        if (type == 'newArrival') newArrivalDynamic.remove(product);



    TLoader.successSnackBar(
        title: 'Successfull', message: "data delete successfully");
  }

  void updateList(ProductModel item) {
    final index = allItems.indexWhere((i) => i == item);
    if (index != -1) allItems[index] = item;

    allItems.refresh();
  }

  // Widget updateProductImage(BuildContext context) {}
}
