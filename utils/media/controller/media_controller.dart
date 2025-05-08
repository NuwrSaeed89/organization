import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:winto/core/constants/app_urls.dart';
import 'package:winto/core/utils/uploads.dart';
import 'package:winto/features/organization/e_commerce/data/models/image_model.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/media/view/widgets/media_uploader.dart';

class MediaController extends GetxController {
  static MediaController get instance => Get.find();
  RxList<XFile> selectedImage = <XFile>[].obs;

  RxBool isUploading = false.obs;
  RxBool showImagesUploaderSection = false.obs;
  final RxList<ImageModel> selectedImagesToUpload = <ImageModel>[].obs;
  late DropzoneViewController dropzoneController;
// String mediaPath = 'https://iwinto.cloud/uploads/';
// String compressedMediaPath = 'https://iwinto.cloud/uploadsCompressed/';

  Future<List<XFile>> selectImages(bool? multi) async {
    List<XFile> list = [];

    if (multi!) {
      list = await ImagePicker().pickMultiImage();
    } else {
      list = (await ImagePicker().pickImage(source: ImageSource.gallery))
          as List<XFile>;
    }
    if (list.isNotEmpty) {
      selectedImage.addAll(list);

      return list;
    }
    return [];
  }

  Future<List<String>> uploadImages(List<XFile> localImages) async {
    try {
      isUploading.value = true;

      List<String> s3 = [];
      if (localImages == []) return s3;
      for (var image in localImages) {
        if (kDebugMode) {
          print(image);
        }
        File img = File(image.path);
        if (kDebugMode) {
          // print(ref.read(userMapProvider.notifier).state!['uid']);
          print("================= befor ======= upload==");
          print(img);
        }

        var s = await uploadMediaToServer(img);

        s3.assign("$mediaPath$s");
        if (kDebugMode) {
          print(
              "================= uploaded= compressed ========== $mediaPath$s");
        }
      }
      isUploading.value = false;
      //show success message
      // TFullScreenLoader.stopLoading();
      return s3;
    } catch (e) {
      if (kDebugMode) {
        print("=========Exception while upload $e");
      }

      return [];
    }
  }

  Future<List<ImageModel>?> selectImageFromMedia(
      {List<String>? selectedUrl,
      bool allowSelection = true,
      bool multipleSelection = false}) async {
    showImagesUploaderSection.value = true;
    List<ImageModel>? selectedImages = await Get.bottomSheet<List<ImageModel>>(
        isScrollControlled: false,
        backgroundColor: TColors.primaryBackground,
        const FractionallySizedBox(
          heightFactor: 1,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  MediaUploader(),
                ],
              ),
            ),
          ),
        ));
  }
}
