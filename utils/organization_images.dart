import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/app/providers.dart';
import 'package:winto/core/constants/app_urls.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/core/utils/media_compression.dart';
import 'package:winto/core/utils/uploads.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_managment.dart';

uploadLogoAndSaveToFirestore(
    BuildContext context, WidgetRef ref) async {
  try {
    // Pick an image from the gallery
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 60);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: isArabicLocale()? "تعديل لوغو المتجر"   : 'Edit Logo Image',
              toolbarColor: Colors.white,
              toolbarWidgetColor: Colors.black,
              initAspectRatio:
                  CropAspectRatioPreset.square, // Ensures a 1:1 crop
              lockAspectRatio: true, // Prevents resizing
              hideBottomControls: true,
              cropStyle: CropStyle.circle),
          IOSUiSettings(
              title:  isArabicLocale()?  "تعديل لوغو المتجر" :'Edit Logo Image',
              aspectRatioLockEnabled: true, // Locks aspect ratio
              cropStyle: CropStyle.circle),
        ],
      );

      ref.read(userMapProvider.notifier).update((state) {
        return {
          ...state!,
          'organizationLogo': 'loading',
        };
      });

      File img = File(croppedFile!.path);

      File compressedFile = await compressImageToWebP(img);

      // Upload image to Firebase Storage
      /* var storageReference =
          FirebaseStorage.instance.ref().child('images/$userId_/profile');
      await storageReference.putFile(img); */

      // Get the URL of the uploaded image
      String imageName = await uploadMediaToServer(compressedFile);

      // String imageName = await uploadMediaToVpsAndGetUrl(img) ?? 'n/a';

      //update the value locally
      ref.read(userMapProvider.notifier).update((state) {
        return {
          ...state!,
          'organizationLogo': mediaPath + imageName,
          'compressedorganizationLogo': compressedMediaPath + imageName
        };
      });

      // Update the user's document in Firestore with the image URL
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ref.read(userMapProvider.notifier).state!['uid'])
          .update({
        'organizationLogo': mediaPath + imageName,
        'compressedorganizationLogo': compressedMediaPath + imageName
      });

      log('Image uploaded successfully. URL: $imageName');
         Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPlaceManagment(
                                        vendorId: ref.read(userMapProvider.notifier).state!['uid'], editMode: true)));
    } else {
      log('No image selected.');
    }
  } catch (e) {
    log('error in photos ..');
    log(e.toString());
  }
}

uploadorganizationBannerImageAndSaveToFirestore(BuildContext context, WidgetRef ref) async {
  try {
    // Pick an image from the gallery
    var pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 60);

    if (pickedFile != null) {
// Calculate 60% of the screen height
      final cropHeight = 100.h * 0.6;

// Calculate the aspect ratio (width : height)
      final aspectRatio = 100.w / cropHeight;

// Perform the crop operation
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        aspectRatio: CropAspectRatio(
          ratioX: 100.w,
          ratioY: cropHeight,
        ),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: isArabicLocale()? 'تعديل غلاف المتجر'    :'Edit Shop Cover',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true, // Lock aspect ratio for consistent cropping
            hideBottomControls: true, // Hide the editing controls
          ),
          IOSUiSettings(
            title:isArabicLocale()?  'تعديل الغلاف' : 'Edit Cover',
            aspectRatioLockEnabled: true, // Lock aspect ratio on iOS
          ),
        ],
      );

      File img = File(croppedFile!.path);

      ref.read(userMapProvider.notifier).update((state) {
        return {
          ...state!,
          'organizationCover': 'loading',
        };
      });

      File compressedFile = await compressImageToWebP(img);

      /* // Upload image to Firebase Storage
      var storageReference =
          FirebaseStorage.instance.ref().child('images/$userId_/banner');
      await storageReference.putFile(img); */

      // Get the URL of the uploaded image
             Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPlaceManagment(
                                        vendorId: ref.read(userMapProvider.notifier).state!['uid'], editMode: true)));

      String imageName = await uploadMediaToServer(compressedFile);

      // String imageUrl = await uploadMediaToVpsAndGetUrl(img) ?? 'n/a';

      //update the value locally
      ref.read(userMapProvider.notifier).update((state) {
        return {
          ...state!,
          'organizationCover': mediaPath + imageName,
        };
      });

      // Update the user's document in Firestore with the image URL
      await FirebaseFirestore.instance
          .collection('users')
          .doc(ref.read(userMapProvider.notifier).state!['uid'])
          .update({
        'organizationCover': mediaPath + imageName,
      });

      log('Image uploaded successfully. URL: $imageName');

    } else {
      log('No image selected.');
    }
  } catch (e) {
    log('error in photos ..');
    log(e.toString());
  }
}
