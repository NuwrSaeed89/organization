import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winto/core/constants/app_urls.dart';
import 'package:winto/core/utils/uploads.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/http/network.dart';
import 'package:winto/features/organization/e_commerce/utils/media/controller/media_controller.dart';

import '../data/models/category_model.dart';
import '../data/repositories/category_repository.dart';
import '../utils/loader/loaders.dart';

class CreateCategoryController extends GetxController {
  static CreateCategoryController get instance => Get.find();

  final isLoading = false.obs;
  final categoryRepository = CategoryRepository.instance;
  final selectedParent = CategoryModel.empty().obs;
  RxString imageUrl = ''.obs;
  RxString localImage = ''.obs;
  RxString message = ''.obs;
  final isFeatured = false.obs;
  final isUploading = false.obs;

  final name = TextEditingController();
  final arabicName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final mediaController = Get.put(MediaController());

  Future<void> pickImage() async {
    var pickedFile =
        (await ImagePicker().pickImage(source: ImageSource.gallery));

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: CropAspectRatio(ratioX: 600, ratioY: 600),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Edit Category Image',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio:
                CropAspectRatioPreset.original, // Ensures a 1:1 crop
            lockAspectRatio: true,
            cropStyle: CropStyle.circle,
            hideBottomControls: true,
          ),
          IOSUiSettings(
            title: 'Edit Category Image',
            cropStyle: CropStyle.circle,

            // Locks aspect ratio
          ),
        ],
      );
      File img = File(croppedFile!.path);

      localImage.value = img.path;
    }
  }

  Future<void> uploadImage() async {
    message.value = "uploading img";
    if (localImage.value == "") return;
    File img = File(localImage.value);
    if (kDebugMode) {
      print("================= befor ==upload category=======");
      print(img.path);
    }
    var s = await uploadMediaToServer(img);
    imageUrl.value = "$mediaPath$s";
    if (kDebugMode) {
      print("uploading url===${imageUrl.value}");
      message.value = "uploading url====${imageUrl.value} ";
    }
    return;
  }

  Future<void> createCategory() async {
    //  isLoading.value = true;

    // final isConnected = await NetworkManager.instance.isConnected();
    // if (!isConnected) {
    //   LoadingFullscreen.stopLoading();
    //   isLoading(false);
    // }
    // if (formKey.currentState!.validate()) {
    //   isLoading.value = false;

    //   return;
    // }

    message.value = "upload photos ..";
    await uploadImage();
    final newCat = CategoryModel(
        name: name.text.trim(),
        image: imageUrl.value,
        parentId: selectedParent.value.id ?? '',
        createdAt: DateTime.now(),
        arabicName: arabicName.text.trim(),
        isFeature: isFeatured.value);

// third send category values

    try {
      var userId = FirebaseAuth.instance.currentUser!.uid;
      if (userId.isEmpty) {
        throw 'Unable to find user information. try again later';
        // LoadingFullscreen.stopLoading();
      }
      message.value = "send data..";
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
      message.value = "evry thing done";
      CategoryController.instance.addItemToLists(newCat);
      resetFields();
      LoadingFullscreen.stopLoading();
      message.value = "";
    } catch (e) {
      throw 'some thing go wrong while add category';
    }
  }

  void resetFields() {
    selectedParent(CategoryModel.empty());
    isLoading(false);
    isFeatured(false);
    name.clear();
    localImage.value = "";
    arabicName.clear();
    imageUrl.value = "";
  }
}
