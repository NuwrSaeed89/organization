import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/banner/controller/banner_controller.dart';
import 'package:winto/features/organization/e_commerce/features/banner/view/all/all_banners.dart';
import 'package:winto/features/organization/e_commerce/features/product/cashed_network_image.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class CustomSlider extends StatelessWidget {
  CustomSlider(
      {super.key,
      this.autoPlay = true,
      this.editMode = false,
      required this.prefferHeight,required this.prefferWidth,

      required this.images
     });
  final bool editMode;
  final bool autoPlay;
double prefferWidth;
double prefferHeight;
  final List<String> images;
  @override
 
  Widget build(BuildContext context) {
 
 return
       images.isEmpty?
          SizedBox(
          width:prefferWidth,
height: prefferHeight,
child: Image.asset(
              'assets/images/ecommerce/placeholder.jpg',
              width:prefferWidth,
height: prefferHeight,
            ),
        ):
     CarouselSlider(
                options: CarouselOptions(
             aspectRatio: 6 / 8,
                    // viewportFraction: 100,
                       scrollPhysics: BouncingScrollPhysics(),
                        autoPlay:autoPlay,
                       ),
                  items: images.map((e)=> CustomCaChedNetworkImage(width: prefferWidth, height: prefferHeight, url: e, raduis: BorderRadius.circular(15)),).toList());
  }}