import 'package:flutter/material.dart';

import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {Key? key,
      required this.subTitle,
      required this.title,
      required this.image,
      required this.onPressed})
      : super(key: key);
  final String image, title, subTitle;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Get.locale?.languageCode == 'en'
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  top: THelperFunctions.screenHeight() / 5,
                  left: TSizes.defaultSpace,
                  right: TSizes.defaultSpace),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                        image,
                      ),
                      width: THelperFunctions.screenwidth() * 0.6,
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtWsections,
                    ),
                    Text(title,
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: TSizes.spaceBtWItems,
                    ),
                    Text(title,
                        style: Theme.of(context).textTheme.labelMedium,
                        textAlign: TextAlign.center),
                    const SizedBox(
                      height: TSizes.spaceBtWsections,
                    ),
                    SizedBox(
                      width: THelperFunctions.screenwidth() * 0.6,
                      child: ElevatedButton(
                          onPressed: onPressed, child: const Text('Continue')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
