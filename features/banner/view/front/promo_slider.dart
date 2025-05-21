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
import 'package:winto/features/social/presentation/widgets/posts/network/display/display_image_full.dart';

class TPromoSlider extends StatelessWidget {
  TPromoSlider(
      {super.key,
      this.autoPlay = true,
      this.editMode = false,
      required this.vendorId});
  final bool editMode;
  final bool autoPlay;
  final String vendorId;
  @override
  final renderOverlay = true;
  final visible = true;
  final switchLabelPosition = false;
  final extend = false.obs;
  final mini = false;
  final customDialRoot = false;
  final closeManually = false;
  final useRAnimation = true;
  final isDialOpen = ValueNotifier<bool>(false);
  final speedDialDirection =
      isArabicLocale() ? SpeedDialDirection.right : SpeedDialDirection.left;
  final buttonSize = const Size(40.0, 40.0);
  final childrenButtonSize = const Size(45.0, 45.0);

  Widget build(BuildContext context) {
     double width=85.w;
  
     double aspectRatio=0.5882;
        double height=width*aspectRatio;
   final controller = BannerController.instance;
  BannerController.instance.fetchUserBanners(vendorId);
    return Obx(() {
      // if (controller.isloadUserBanner.value) {
      //   return Container(
      //     color: Colors.transparent,
        
      //     child: const Center(
      //         child: SizedBox(  width: 364,
      //                       height: 200, child: TLoaderWidget())),
      //   );
      // } else
       if (controller.activeBanners.isEmpty) {
        return editMode
            ?
             Container(
              color: Colors.transparent,
               padding: const EdgeInsets.only(bottom:10.0),
       
               child: CarouselSlider(
                carouselController: CarouselSliderController(),
                  options: CarouselOptions(
                              aspectRatio:aspectRatio,
                       height:height+20,
                     viewportFraction: 0.85,
                     enlargeCenterPage: true,
                    //autoPlay: true,
                   // height: 200,
                 //   enlargeCenterPage: true,
               
                    autoPlay: true,
                  ),
                  items: List.generate(3, (index) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: TRoundedContainer(
                           width: width,
              height:height,
                            enableShadow: true,
                            showBorder: true,
                            backgroundColor: TColors.white,
                            radius: BorderRadius.circular(22),
                          ),
                        ),
                        Center(
                            child: GestureDetector(
                          onTap: () => controller.addBanner('gallery', vendorId),
                          child: TRoundedContainer(
                            enableShadow: true,
                            showBorder: true,
                            width: 50,
                            height: 50,
                            radius: BorderRadius.circular(300),
                            child: const Icon(
                              CupertinoIcons.add,
                              color: TColors.primary,
                            ),
                          ),
                        )),
                      ],
                    );
                  })),
             )
            : const SizedBox.shrink();
      } 
      
      
        
        
        else {
         
          
          var   items = controller.activeBanners
                .map((e) => e.image)
                .toList()
                .map((item) => Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: TRoundedContainer(
                          showBorder: true,
                         
             
                          radius: BorderRadius.circular(15),
                          child: GestureDetector(
                            onTap: ()=> Navigator.push(  context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NetworkImageContainerFullSize(
                                     item))),
                            child: CustomCaChedNetworkImage(
                               width: width,
                                          height: height,
                              url: item,
                              raduis: BorderRadius.circular(15),
                            ),
                          )),
                    ))
                .toList();
            if (controller.activeBanners.length == 1 && editMode) {
              items.add(Padding(
                padding: EdgeInsets.only(bottom: 10),
                child:  TRoundedContainer(
                  showBorder: true,
                  height: height,
                  width:width,
                  enableShadow: true,
                  radius: BorderRadius.circular(15),
                  child: Center(
                    child: InkWell(
                       onTap: () =>
                                    controller.addBanner('gallery', vendorId),
                      child: TRoundedContainer(
                        enableShadow: true,
                        //showBorder: true,
                        width: 50,
                        height: 50,
                        radius: BorderRadius.circular(300),
                        child: const Icon(
                          CupertinoIcons.add,
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ));
    
              items.add(Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TRoundedContainer(
                  showBorder: true,
              // height: 214,
              // width: 364,
                  enableShadow: true,
                  radius: BorderRadius.circular(15),
                 child: Center(
                    child: InkWell(
                       onTap: () =>
                                    controller.addBanner('gallery', vendorId),
                      child: TRoundedContainer(
                        enableShadow: true,
                        width: 50,
                        height: 50,
                        radius: BorderRadius.circular(300),
                        child: const Icon(
                          CupertinoIcons.add,
                          color: TColors.primary,
                        ),
                      ),
                    ),
                 ),
                ),
              ));
            }
            if (controller.activeBanners.length == 2 && editMode) {
              items.add(Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: TRoundedContainer(
                  showBorder: true,
              //  height: 214,
              // width: 364,
                  enableShadow: true,
                  radius: BorderRadius.circular(15),
                  child: Center(
                     child: CustomFloatActionButton(onTap: ()=> controller.addBanner('gallery', vendorId))
                    // child: GestureDetector(
                    //    onTap: () =>
                    //                 controller.addBanner('gallery', vendorId),
                    //   child: TRoundedContainer(
                    //     enableShadow: true,
                    //     //showBorder: true,
                    //     width: 50,
                    //     height: 50,
                    //     radius: BorderRadius.circular(300),
                    //     child: const Icon(
                    //       CupertinoIcons.add,
                    //       color: TColors.primary,
                    //     ),
                    //   ),
                    // ),
                  ),
                ),
              ));
            }
    
            return Stack(
              children: [
                CarouselSlider(
                    options: CarouselOptions(
                
      aspectRatio:aspectRatio,
    
              height :height+20,
        viewportFraction: 0.85,
        enlargeCenterPage: true,
                       // enableInfiniteScroll: true,
                     
                        // تعطيل التكرار إذا كان عدد الصور = 1
                       scrollPhysics: BouncingScrollPhysics(),
                        autoPlay: items.length > 1,
                        onPageChanged: (index, _) =>
                            controller.updatePageIndicator(index)),
                    items: items),
                     Visibility(
                      visible: editMode,
                       child: Positioned(
                             bottom: 15,
                              right: isArabicLocale() ? null : 7,
                              left: isArabicLocale() ? 7 : null,
                        
                        
                        child: CustomFloatActionButton( onTap: () => Get.to(BannersMobileScreen(
                                  vendorId: vendorId,
                        )),icon: Icons.settings,)),
                     ),
    
    
                Visibility(
                  visible: false,
                  child: Container(
                    height: 214,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: isArabicLocale()
                            ? Alignment.bottomLeft
                            : Alignment.bottomRight,
                        child: SpeedDial(
                          overlayOpacity: 0,
                          icon: Icons.edit,
                          iconTheme: const IconThemeData(size: 30),
                          activeIcon: Icons.close,
                          spacing: 0,
                          mini: mini,
                          openCloseDial: isDialOpen,
                          childPadding: const EdgeInsets.all(3),
                          spaceBetweenChildren: 4,
                          buttonSize: buttonSize,
                          childrenButtonSize: childrenButtonSize,
                          visible: visible,
                          direction: speedDialDirection,
                          switchLabelPosition: switchLabelPosition,
                          closeManually: false,
                          renderOverlay: renderOverlay,
                          useRotationAnimation: useRAnimation,
                          backgroundColor: Theme.of(context).cardColor,
                          foregroundColor: TColors.black,
                          elevation: 4,
                          animationCurve: Curves.elasticInOut,
                          isOpenOnStart: false,
                          shape: customDialRoot
                              ? const RoundedRectangleBorder()
                              : const StadiumBorder(),
                          onOpen: () {
                            extend.value = true;
                          },
                          onClose: () {
                            extend.value = false;
                          },
                          children: [
                            SpeedDialChild(
                              elevation: 0,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    Icon(Icons.settings, color: TColors.black),
                              ),
                              onTap: () => Get.to(BannersMobileScreen(
                                vendorId: vendorId,
                              )), //EditCategory
                            ),
                            SpeedDialChild(
                                elevation: 0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(TImages.add,
                                      color: TColors.black),
                                ),
                                onTap: () =>
                                    controller.addBanner('gallery', vendorId)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                ],
            );
          }
        
      }
    );
  }
}
