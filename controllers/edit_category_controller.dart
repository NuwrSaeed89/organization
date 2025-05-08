import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winto/core/constants/app_urls.dart';
import 'package:winto/core/utils/dialogs/reusable_dialogs.dart';
import 'package:winto/core/utils/uploads.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/http/network.dart';
import 'package:winto/features/organization/e_commerce/utils/media/controller/media_controller.dart';

import '../data/models/category_model.dart';
import '../data/repositories/category_repository.dart';
import '../features/category/view/create_category/widget/image_uploader.dart';
import '../utils/loader/loaders.dart';

class EditCategoryController extends GetxController {
  static EditCategoryController get instance => Get.find();

  final isLoading = false.obs;
  final categoryRepository = CategoryRepository.instance;
  final selectedParent = CategoryModel.empty().obs;
  RxString imageUrl = ''.obs;
  RxString localImage = ''.obs;
  RxString message = ''.obs;
  final isFeatured = true.obs;
  final name = TextEditingController();
  final arabicName = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final mediaController = Get.put(MediaController());
  String oldImg = "";
  void init(CategoryModel category) {
    name.text = category.name;
    oldImg = category.image!;
    // isFeatured.value = category.isFeature!;
    arabicName.text = category.arabicName;
    imageUrl.value = category.image!;
  }

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

  Future<void> updateCategory(CategoryModel category) async {
    message.value = "now upload image ";
    // first upload category to server
    if (localImage.isNotEmpty) await uploadImage();

    message.value = "now inserting ";
// second create category model
    category.arabicName = arabicName.text.trim();
    category.name = name.text.trim();
    category.image = imageUrl.value;
    category.isFeature = isFeatured.value;
    category.updatedAt = DateTime.now();

// third send category values

    await CategoryRepository.instance.updateCategory(category);

    CategoryController.instance.updateItemFromLists(category);
    resetFields();
    message.value = "";
    return;
    //  LoadingFullscreen.stopLoading();
  }

  Future<dynamic> updateCategoryImage(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (_) => SizedBox(
              height: 800,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: DottedBorder(
                        dashPattern: const [4, 5],
                        borderType: BorderType.RRect,
                        color: TColors.darkerGray,
                        radius: const Radius.circular(10),
                        child: Obx(
                          () => TImageUploader(
                            circuler: false,
                            imageType: localImage.isNotEmpty
                                ? ImageType.file
                                : ImageType.asset,
                            width: 80,
                            height: 80,
                            image: localImage.isNotEmpty
                                ? localImage.value
                                : TImages.imagePlaceholder,
                            onIconButtonPressed: () => pickImage(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  void resetFields() {
    selectedParent(CategoryModel.empty());
    isLoading(false);
    isFeatured(false);
    name.clear();
    arabicName.clear();
    imageUrl.value = "";
  }

  Future<void> deleteCategory(CategoryModel category) async {
    LoadingFullscreen.startLoading();

    var userId = FirebaseAuth.instance.currentUser!.uid;
    if (userId.isEmpty) {
      throw 'Unable to find user information. try again later';
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('organization')
        .doc('1')
        .collection('category')
        .doc(category.id)
        .delete();

    // categoryRepository.deleteCategory(category);
    CategoryController.instance.removeItemFromLists(category);
    LoadingFullscreen.stopLoading();
  }
}
