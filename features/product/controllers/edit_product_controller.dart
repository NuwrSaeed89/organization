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
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/product_details.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/loaders.dart';

class EditProductController extends GetxController {
  static EditProductController get instance => Get.find();

  //Variables
  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  // final skuCode = TextEditingController();
  final title = TextEditingController();
  final arabicTitle = TextEditingController();

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
    title.text = product.title;
    initialImage.value=product.images!;
    arabicTitle.text = product.arabicTitle;
    description.text = product.description!;
    arabicDescription.text = product.arabicDescription!;
    oldPrice.text = product.oldPrice.toString();
    price.text = product.price.toString();

    images.value = product.images!;
    selectedCategory.value = product.category!;

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

  Future<void> updateProduct(ProductModel product, String vendorId) async {
    // message.value = "now update Thumbnail ";
    // first upload thumbnail to server
    // await uploadImage();
    // if (oldthumb != localThumbnail.value) {
    //   uploadThumbnail();
    //   //product.thumbnail = thumbnailUrl.value;
    // }

    // update Extra images
    // List<XFile> forNewUpload = [];
product.images=initialImage;
    if (selectedImage.isNotEmpty) {
      message.value = isArabicLocale()
          ? "يتم الان رفع الصور"
          : "now uploading extra images";
      List<String> s3 = await uploadImages(selectedImage);
      for (var image in s3) {
        product.images?.add(image);
      }
    }

    message.value = isArabicLocale() ? 'يتم الأن التعديل' : "now inserting ";
// second create category model
    product.title = title.text.trim();
    product.productType = type;
    // product.sku = skuCode.text.trim();
    product.arabicTitle = arabicTitle.text.trim();
    product.price = double.parse(price.text.toString());
    product.oldPrice=  double.tryParse(oldPrice.text.toString());
    product.description = description.text.trim();
    product.arabicDescription = arabicDescription.text.trim();

    product.isFeature = true;
    product.category = selectedCategory.value;

// third send category values
    //productRepository.updateProduct(product);

    try {
      if (vendorId.isEmpty) {
        throw 'Unable to find user information. try again later';
      }
      productRepository.updateProduct(product, vendorId);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('Products')
          .doc(product.id)
          .update(product.toJson());
    } catch (e) {
      throw 'some thing go wrong while updating category';
    }
 // Navigator.pop(Get.context!);
    Navigator.pop(Get.context!);
   Get.to(ProductDetails(product: product, vendorId: vendorId));
    ProductController.instance.updateList(product);
    resetFields();

    //  LoadingFullscreen.stopLoading();
    message.value = "";
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
}
