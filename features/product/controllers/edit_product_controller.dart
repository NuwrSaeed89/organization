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
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_repository.dart';

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
  final salePrice = TextEditingController();

  final categoryTextField = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Rx<CategoryModel> category = CategoryModel.empty().obs;
  RxList<String> images = <String>[].obs;
  RxString message = ''.obs;
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
      selectedImage.removeWhere((img) => img.path == imagePath);
      selectedImage.add(XFile(croppedFile.path));
    }
  }

  void init(ProductModel product) {
    if (kDebugMode) {
      print('=========id==========${product.id}');
    }
    localThumbnail.value = "";
    title.text = product.title;

    arabicTitle.text = product.arabicTitle;
    description.text = product.description!;
    arabicDescription.text = product.arabicDescription!;
    salePrice.text = product.salePrice.toString();
    price.text = product.price.toString();

    images.value = product.images!;
    category.value = product.category!;

    categoryTextField.text = product.category!.arabicName;
    oldExtraImages.assignAll(product.images!);
  }

  void resetFields() {
    isLoading(false);

    title.clear();
    arabicTitle.clear();
    description.clear();
    arabicDescription.clear();
    price.text = 0.toString();
    salePrice.text = 0.toString();

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

    // forNewUpload.assignAll(selectedImage);
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
    product.salePrice = double.parse(salePrice.text.toString());
    product.description = description.text.trim();
    product.arabicDescription = arabicDescription.text.trim();

    product.isFeature = true;
    product.category = category.value;

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
