import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/media/controller/media_controller.dart';

import 'widgets/media_uploader.dart';

class MediaScreen extends StatelessWidget {
  const MediaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(MediaController());
    return const Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediaUploader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
