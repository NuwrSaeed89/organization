import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/banner/controller/banner_controller.dart';
import 'package:winto/features/organization/e_commerce/features/banner/view/all/widgets/banner_list_item.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/customFloatingButton.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_widgets.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/larg_listTileShimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class BannersMobileScreen extends StatelessWidget {
  const BannersMobileScreen({super.key, required this.vendorId});
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    final controller = BannerController.instance;
    controller.fetchBanners(vendorId);

    // final banners = controller.fetchBanners();
    return SafeArea(
        child: Directionality(
            textDirection:
                isArabicLocale() ? TextDirection.rtl : TextDirection.ltr,
            child: Scaffold(
                floatingActionButton: CustomFloatActionButton(
                    onTap: () => controller.addBanner('gallery', vendorId)),
                appBar: CustomAppBar(
                  title:
                      AppLocalizations.of(context).translate('shop.allBanners'),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(
                       
                        () {
                          if (controller.loading.value) {
                            return const TLargListTilehummer();
                          }else
                          if (controller.banners.isEmpty) {
                            return Center(
                              child: SizedBox(
                                height: 300,
                                width: 80.w,
                                child: Center(
                                  child: Text(
                                   isArabicLocale()? ' لا يوجد بنرات قم بإضافة البعض ':'there is no Banners add some photos',
                                    style: titilliumBold.copyWith(fontSize: 20),
                                  ),
                                ),
                              ),
                            );
                          }
                         
                       else{
                          return Obx(
                            () => ListView.separated(
                                separatorBuilder: (_, __) =>
                                    TCustomWidgets.buildDivider(),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.banners.length,
                                itemBuilder: (_, index) => TBannerItem(
                                    banner: controller.banners[index],
                                    vendorId: vendorId)),
                          );
                          }  },
                      ),
                      SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ))));
  }
}
