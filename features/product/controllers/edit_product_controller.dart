import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/constants/app_urls.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/core/utils/uploads.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/loaders.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  //Variables
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  // final skuCode = TextEditingController();
  final title = TextEditingController();
  final arabicTitle = TextEditingController();
String t="";
String a="";
  final description = TextEditingController();
  final arabicDescription = TextEditingController();
  final price = TextEditingController();
  final oldPrice = TextEditingController();
var salePrice = 00.0.obs;
  final saleprecentage = TextEditingController();
  final categoryTextField = TextEditingController();
  final formKey = GlobalKey<FormState>();
 CategoryModel category = CategoryModel.empty();
  RxList<String> images = <String>[].obs;
  RxList<String> initialImage = <String>[].obs;
  RxString message = ''.obs;
   Rx<CategoryModel> selectedCategory =CategoryModel.empty().obs;
  String oldthumb = '';
  String type = '';
  List<String> oldExtraImages = [];
  RxList<XFile> selectedImage = <XFile>[].obs;
  RxString localThumbnail = ''.obs;

  RxString thumbnailUrl = ''.obs;
  void takeCameraImages() async {
    var tackenImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (tackenImage != null) {
      selectedImage.add(tackenImage);
    }
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

       var i= selectedImage.indexWhere((img) => img.path == imagePath);
      selectedImage.removeWhere((img) => img.path == imagePath);

      selectedImage.insert(i,XFile(croppedFile.path));
      // selectedImage.removeWhere((img) => img.path == imagePath);
      // selectedImage.add(XFile(croppedFile.path));
    }
  }

  void init(ProductModel product) {
    if (kDebugMode) {
      print('=========id==========${product.id}');
    }
    localThumbnail.value = "";
    title.text = product.title??"";
    t=product.title;
    a=product.arabicTitle;
    initialImage.value=product.images!;
    arabicTitle.text = product.arabicTitle??"";
    description.text = product.description??"";
    arabicDescription.text = product.arabicDescription??"";
    oldPrice.text =  product.oldPrice==null ?"": product.oldPrice.toString();
    price.text = product.price.toString();

    images.value = product.images!;
    if(product.category != CategoryModel.empty() ) {
      selectedCategory.value =CategoryController.instance.allItems.where((c)=> c.id==product.category!.id).single;
    }
    categoryTextField.text = product.category!.arabicName;
    oldExtraImages.assignAll(product.images!);
  }

  void resetFields() {
    isLoading(false);

    title.clear();
    arabicTitle.clear();
    description.clear();
    arabicDescription.clear();
    price.text = 0.0.toString();
    oldPrice.text = '';
selectedImage.clear();
    selectedImage.value = [];
    thumbnailUrl.value = "";
    localThumbnail.value = "";
  }

  Future<void> updateProduct(ProductModel product, String vendorId) async 
  {
  product.images=initialImage;
  var oldimages=initialImage.length;
     var  salePriceNumber = double.parse(price.text.replaceAll(',', ''));
     var oldPriceNumber=double.tryParse(oldPrice.text.toString())??0.00;
   if(t.isEmpty && a.isEmpty){//Check the titles
   TLoader.warningSnackBar(
          title:'',
          message: isArabicLocale()
              ?"الرجاء إدخال اسم العنصر بإحدى اللغتين "
              : "Please add at least one title");    
   return;
}else if (!formKey.currentState!.validate()) {
      isLoading.value = false;
     // Navigator.pop(Get.context!);
      return;
    }
else  if (selectedImage.isEmpty && oldimages<1 ) {
     
      TLoader.warningSnackBar(
          title:'',
          message: isArabicLocale()
              ? "يرجى ادخال صورة على الأقل"
              : "Please add at least one photo");
    // Get.closeCurrentSnackbar();
      return;
      } 
        else if (selectedCategory.value == CategoryModel.empty()) {
      isLoading.value = false;
      TLoader.warningSnackBar(
          title:'',
          message: isArabicLocale()
              ? "يرجى اختيار تصنيف "
              : "Please select a category");
    // Get.closeCurrentSnackbar();
      return;
    } 
     else if(oldPriceNumber < salePriceNumber && oldPriceNumber>0.00 ) {
      TLoader.warningSnackBar(
          title:'',
          message: isArabicLocale()
              ? "سعر البيع يجب ان يكون أقل من السعر"
              : "Sale price should be less than Price");
    // Get.closeCurrentSnackbar();
      return;
        }
     else{
  showProgressBar();
      List<String> s3 = await uploadImages(selectedImage);
      for (var image in s3) {
        product.images?.add(image);}

    product.title = t;
    product.productType = type;
    // product.sku = skuCode.text.trim();
    product.arabicTitle = a;
    product.price = salePriceNumber;
    product.oldPrice= oldPriceNumber;
    product.description = description.text.trim();
    product.arabicDescription = arabicDescription.text.trim();

    product.isFeature = true;
    product.category = selectedCategory.value;
      
    try {
     productRepository.updateProduct(product, vendorId);
      Get.closeCurrentSnackbar();




  
    } catch (e) {
     Get.closeCurrentSnackbar();
      throw 'some thing go wrong while updating category';
   }
      TLoader.successSnackBar(
        title: 'Successfull', message: "data updated successfully");
  }
    resetFields();
    Navigator.pop(Get.context!);
    //  Navigator.push(
    //                   Get.context!,
    //                   MaterialPageRoute(
    //                       builder: (context) => ProductDetails(
    //                           vendorId: vendorId, product: product,)));
     }
  
void showProgressBar() {
  Get.snackbar(
   
    isArabicLocale()? "جاري التعديل..." :"Updating Now ..",
    "",
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
    backgroundColor:TColors.primary,
    colorText: Colors.white,
    duration: Duration(days: 1),
    isDismissible: false,
    showProgressIndicator: true,
     padding: EdgeInsets.symmetric(horizontal:  50),
    
    
    progressIndicatorBackgroundColor: Colors.white,
  );
}
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
            toolbarTitle: 'Edit Product Image',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'Edit Product Image',
            // Locks aspect ratio
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
 var regularPrice = 0.0.obs;
  var discountPrice = Rxn<double>(); // يسمح بأن يكون فارغًا

  Future<void> uploadThumbnail() async {
    message.value = "uploading thumbnail";
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
      message.value = "uploading thumb done";
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

  void formatInput(String value) {
    if (value.isNotEmpty) {
      double? number = double.tryParse(value.replaceAll(',', ''));
      if (number != null) {
      
       price.value = TextEditingValue(
          text: formatter.format(number),
          selection: TextSelection.collapsed(offset: formatter.format(number).length),
        );
      }
    }
  }
   
 final NumberFormat formatter = NumberFormat("#,##0", "en_US"); 
double? priceNumber;


   void changePrice(String value) {

if (double.parse(value) >100){
    TLoader.warningSnackBar(title: '',message:  isArabicLocale()?"نسبة الادخال الصحيحة اقل من 100" :"Sale precentage should be less than 100");
     return;
}
    if(oldPrice.text.isNotEmpty){
 
var s= double.tryParse(oldPrice.text.toString().replaceAll(',', '')) ??0.00;
var p=    (s-(s*(double.parse(value)/100)));
//changePrice(p.toString());
//
  formatInput(p.toString());
  }
  }
  
  void changeSalePresentage(String value) {
    if (kDebugMode) {
      print("===========value is ====$value");
    }
    if(saleprecentage.text.isNotEmpty){
      var s=double.parse(saleprecentage.text.toString());
      var p= double.parse(value)- (s*(double.parse(value)/100));
     // price.text="";
     formatInput(p.toString());
    }


    if (value.isNotEmpty) {
      double? number = double.tryParse(value.replaceAll(',', ''));
      if (number != null) {
      
       oldPrice.value = TextEditingValue(
          text: formatter.format(number),
          selection: TextSelection.collapsed(offset: formatter.format(number).length),
        );
      }
    }


    }

  

}
