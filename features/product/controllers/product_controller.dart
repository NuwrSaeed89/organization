import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/constants/app_urls.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/core/utils/uploads.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/loaders.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();




 

  //Variables
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  List<ProductModel> saleProduct = [];
  final RxList<ProductModel> allItems = <ProductModel>[].obs;
    RxList<ProductModel> tempProducts = <ProductModel>[].obs;
        RxList<ProductModel> spotList= <ProductModel>[].obs;
  final RxList<ProductModel> productCategory = <ProductModel>[].obs;
  final title = TextEditingController();
  final arabicTitle = TextEditingController();
  final description = TextEditingController();
  final arabicDescription = TextEditingController();
  final price = TextEditingController();
  var oldPrice = TextEditingController();
var salePrice = 00.0.obs;
  final saleprecentage = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CategoryModel category = CategoryModel.empty();
  RxList<String> images = <String>[].obs;
  RxString message = ''.obs;
  final searchTextController = TextEditingController();
void deleteTempItems()=> tempProducts = <ProductModel>[].obs;

String t="";
String a="";
  var discountPercentage = 10.0.obs;


  Future<void> createProduct(String type, String vendorId) async {

if(t.isEmpty && a.isEmpty){
   TLoader.warningSnackBar(
          title:'',
          message: isArabicLocale()
              ?"الرجاء إدخال اسم العنصر بإحدى اللغتين "
              : "Please add at least one title");
  
  // Navigator.pop(Get.context!);
      
   return;
}

    if (!formKey.currentState!.validate()) {
      isLoading.value = false;
     // Navigator.pop(Get.context!);
      return;
    }
    if (selectedImage.isEmpty) {
      isLoading.value = false;
      TLoader.warningSnackBar(
          title:'',
          message: isArabicLocale()
              ? "يرجى ادخال صورة على الأقل"
              : "Please add at least one photo");
     // Navigator.pop(Get.context!);
      return;
    } else if (category == CategoryModel.empty()) {
      isLoading.value = false;
      TLoader.warningSnackBar(
          title:'',
          message: isArabicLocale()
              ? "يرجى اختيار تصنيف "
              : "Please select a category");
     Get.closeCurrentSnackbar();
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
        oldPrice:  double.tryParse(oldPrice.text.toString()),
        description: description.text.trim(),
        arabicDescription: arabicDescription.text.trim(),
        images: images,
        isFeature: true,
        category: category,
        productType: type,
      );
      try {
        if (vendorId.isEmpty) {
           Get.closeCurrentSnackbar();
          throw 'Unable to find user information. try again later';
        }
        message.value = isArabicLocale() ? "ارسال البيانات" : "send data..";
        await productRepository.addProducts(product, vendorId)
        
          
        
        
        ;
        message.value = "evry thing done";
        allItems.insert(0,product);
           tempProducts.insert(0,product);
       
        //resetFields();
        if (type == 'offers') offerDynamic.insert(0,product);
        if (type == 'all') allDynamic.insert(0,product);
        if (type == 'all1') allLine1Dynamic.insert(0,product);
        if (type == 'all2') allLine2Dynamic.insert(0,product);
        if (type == 'all3') allLine3Dynamic.insert(0,product);
        if (type == 'sales') salesDynamic.insert(0,product);
        if (type == 'foryou') foryouDynamic.insert(0,product);
        if (type == 'mixone') mixoneDynamic.insert(0,product);
        if (type == 'mixline1') mixline1Dynamic.insert(0,product);
        if (type == 'mixline2') mixline2Dynamic.insert(0,product);
        if (type == 'mostdeamand') mostdeamandDynamic.insert(0,product);
        if (type == 'newArrival') newArrivalDynamic.insert(0,product);
        //spotList.add();
        resetFields();
        message.value = "";
        selectedImage.value = [];
       //images.value=[];
        TLoader.successSnackBar(
            title: '',
            message: isArabicLocale()
                ? "تم الادخال بنجاح"
                : "data insert successfully");
      } catch (e) {
         Get.closeCurrentSnackbar();
        throw 'some thing go wrong while add category';
      }
    }
  }

static Text getArabicText( String s,double size,{int lines=2}){return Text(s, style: titilliumSemiBold.copyWith(fontSize: size, fontWeight: FontWeight.bold),maxLines:lines, textAlign: TextAlign.center,);
}
static Text getEnglishText( String s,double size,{int lines=2}){return Text(s, style: titilliumSemiBold.copyWith(fontSize: size+2, fontWeight: FontWeight.bold),maxLines:lines, textAlign: TextAlign.center);
}
static Text getTitle(ProductModel product, bool isEnglish, double size, {int lines=2}) {
  if(isEnglish)
  {
   return  product.title.isEmpty? getArabicText(product.arabicTitle,size):getEnglishText(product.title, size);
  }
  else{
   return  product.arabicTitle.isEmpty?  getEnglishText(product.title, size):getArabicText(product.arabicTitle,size);
  }
}

  Future<int> getUserProductCount(String userId) async {
    var productCount = productRepository.getUserProductCount(userId);
    return productCount; // عدد المنتجات الخاصة بالمستخدم
  }

  void resetFields() {
    isLoading(false);
    title.clear();
   // images.clear();
    arabicTitle.clear();
    description.clear();
    arabicDescription.clear();
    price.clear();
    oldPrice.clear();
    selectedImage.value = [];
  }

  Future<void> fetchdata(String vendorId) async {
    try {
      var fetchedItem = await productRepository.getAllProducts(vendorId);

      allItems.value = fetchedItem;
     // saleProduct = getSaleProduct();
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
   RxList<ProductModel> allLine3Dynamic = <ProductModel>[].obs;
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
       if (type == 'all3') allLine3Dynamic.value = fetchedItem;
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
  var rotationAngle = 0.0.obs; // زاوية التدوير
  
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

  void updateRotation(double angle) {
    rotationAngle.value = angle;
  }
var scaleFactor = 1.0.obs;  
  void updateScale(double scale) {
    scaleFactor.value = scale;
  }

  Future<void> cropImage(String imagePath) async {
     if (imagePath =="") return;
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
            var i= selectedImage.indexWhere((img) => img.path == imagePath);
      selectedImage.removeWhere((img) => img.path == imagePath);

      selectedImage.insert(i,XFile(croppedFile.path));
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

 

  String? calculateSalePresentage(double price, double? oldPrice) {
    if (oldPrice == null || oldPrice <= 0.0 || price <= 0.0) {
      return null;
    }
    double precentage = ((oldPrice - price) / oldPrice) * 100;
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
          if (type == 'all3') allLine3Dynamic.remove(product);
        if (type == 'sales') salesDynamic.remove(product);
        if (type == 'foryou') foryouDynamic.remove(product);
        if (type == 'mixone') mixoneDynamic.remove(product);
        if (type == 'mixline1') mixline1Dynamic.remove(product);
        if (type == 'mixline2') mixline2Dynamic.remove(product);
        if (type == 'mostdeamand') mostdeamandDynamic.remove(product);
        if (type == 'newArrival') newArrivalDynamic.remove(product);

//Navigator.pop(Get.context!);

    TLoader.successSnackBar(
        title: 'Successfull', message: "data delete successfully");
  }

  void updateList(ProductModel item) {
var type=item.productType;

    if (type == 'offers')
    {  final index = offerDynamic.indexWhere((i) => i == item);
    if (index != -1) offerDynamic[index] = item;
    offerDynamic.refresh();
    }
   if (type == 'all')
   {  final index = allDynamic.indexWhere((i) => i == item);
    if (index != -1) allDynamic[index] = item;
    allDynamic.refresh();
    }
  if (type == 'all1')
        {
    final index = allLine1Dynamic.indexWhere((i) => i == item);
    if (index != -1) allLine1Dynamic[index] = item;
    allLine1Dynamic.refresh();
    }

    if (type == 'all2')
        {
    final index = allLine2Dynamic.indexWhere((i) => i == item);
    if (index != -1) allLine2Dynamic[index] = item;
    allLine2Dynamic.refresh();
    }      
    
       if (type == 'all3')
        {
    final index = allLine3Dynamic.indexWhere((i) => i == item);
    if (index != -1) allLine3Dynamic[index] = item;
    allLine3Dynamic.refresh();
    } 
        if (type == 'sales')
        {
    final index = salesDynamic.indexWhere((i) => i == item);
    if (index != -1) salesDynamic[index] = item;
    salesDynamic.refresh();
    }   
     if (type == 'foryou')
        {
    final index = foryouDynamic.indexWhere((i) => i == item);
    if (index != -1) foryouDynamic[index] = item;
    foryouDynamic.refresh();
    }     
 if (type == 'mixone')
        {
    final index = mixoneDynamic.indexWhere((i) => i == item);
    if (index != -1) mixoneDynamic[index] = item;
    mixoneDynamic.refresh();
        } 
         if (type == 'mixline1')
        {
    final index = mixline1Dynamic.indexWhere((i) => i == item);
    if (index != -1) mixline1Dynamic[index] = item;
    mixline1Dynamic.refresh();
        }  
          if (type == 'mixline2')
        {
   final index = mixline2Dynamic.indexWhere((i) => i == item);
    if (index != -1) mixline2Dynamic[index] = item;
    mixline2Dynamic.refresh();
        }  
   if (type == 'mostdeamand')
        {
    final index = mostdeamandDynamic.indexWhere((i) => i == item);
    if (index != -1) mostdeamandDynamic[index] = item;
    mostdeamandDynamic.refresh();
        }      
      if (type == 'newArrival')
        {
     final index = newArrivalDynamic.indexWhere((i) => i == item);
    if (index != -1) newArrivalDynamic[index] = item;
    newArrivalDynamic.refresh();
        }      


    final index = allItems.indexWhere((i) => i == item);
    if (index != -1) allItems[index] = item;

    allItems.refresh();
  }
//////////////////////

   var selectedCategory = Rx<CategoryModel?>(null);
  var isExpanded = false.obs;

 
  
  void selectCategory(CategoryModel category, String vendorId) async {
    if (selectedCategory.value == category && isExpanded.value) {
      isExpanded.value = false;
    } else {
      selectedCategory.value = category;
      await fetchProducts(category,vendorId);
      isExpanded.value = true;
    }
  }

 

  void closeList() {
    isExpanded.value = false;
  }
 final RxList<ProductModel>products=  <ProductModel>[].obs;
RxBool loadProduct =false.obs;
   Future<void> fetchProducts( CategoryModel category, String vendorId) async {
    loadProduct.value = true;

    try {
     var list = await   //productRepository.getAllProducts(vendorId);
      CategoryController.instance
                                            .getCategoryProduct(
                                                categoryId: category.id!,
                                                userId: vendorId
                                              );

  

      products.assignAll(list);
    } catch (e) {
      print('Error fetching products: $e');
    }

    loadProduct.value = false;
  }
void showProgressBar() {
  Get.snackbar(
   
    isArabicLocale()? "جاري الحفظ..." :"Saving Now ..",
    "",
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    backgroundColor:TColors.primary,
    colorText: Colors.white,
    duration: Duration(days: 1),
    isDismissible: false,
    showProgressIndicator: true,
     padding: EdgeInsets.all( 10),
    
    
    progressIndicatorBackgroundColor: Colors.white,
  );
}

 var regularPrice = 0.0.obs;
  var discountPrice = Rxn<double>(); // يسمح بأن يكون فارغًا


  void validateDiscountPrice(String oldPrice) {
  
      double? enteredPrice = double.tryParse(oldPrice);
      if (enteredPrice != null) {
        if (enteredPrice <= regularPrice.value) {
         
         TLoader.warningSnackBar(title: '',message:"يجب أن يكون سعر البيع أقل  من السعر القديم" );
         
       
        } else {
          discountPrice.value = enteredPrice;
        }
      } else {
        Get.snackbar("تنبيه", "الرجاء إدخال رقم صالح", snackPosition: SnackPosition.TOP,colorText: Colors.white,backgroundColor: Colors.black);
      }
    }

  void changePrice(String value) {
    if(oldPrice.text==''){
    TLoader.warningSnackBar(title: '',message:  isArabicLocale()?"فضلا أدخل السعر ثم ادخل النسبة" :"Please type the price first");
    return;
}
if (double.parse(value) >100){
    TLoader.warningSnackBar(title: '',message:  isArabicLocale()?"نسبة الادخال الصحيحة اقل من 100" :"Sale precentage should be less than 100");
     return;
}


var s=double.parse(oldPrice.text.toString());
var p=    (s-(s*(double.parse(value)/100)));
price.text=p.toString();
  }



  void changeSalePresentage(String value) {}
  }
 

  // Widget updateProductImage(BuildContext context) {}

