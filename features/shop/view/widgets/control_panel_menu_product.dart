import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/app/data.dart';
import 'package:winto/core/constants/colors.dart' as TColors;
import 'package:winto/core/constants/text_styles.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/edit/edit_product.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/dialog/confirmation_dialog.dart';
import 'package:winto/main.dart';

class ControlPanelProduct extends StatelessWidget {
   ControlPanelProduct(
      {super.key, required this.vendorId, required this.product,this.withCircle=false});
  final String vendorId;
  final ProductModel product;
  bool withCircle;
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return PullDownButton(
        routeTheme: const PullDownMenuRouteTheme(
          backgroundColor: Colors.white,
        ),
        itemBuilder: (context) => [
              PullDownMenuItem(
                icon: Icons.edit,
                title:
                    isLocaleEn(context) ? 'Edit this item' : 'تعديل هذا العنصر',
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;
                EditProductController.instance.init(product);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProduct(
                                product: product,
                                vendorId: vendorId,
                              )));
                },
              ),
              PullDownMenuItem(
                  icon: Icons.delete,
                  title: isLocaleEn(context)
                      ? 'Delete this item'
                      : 'حذف هذا العنصر',
                  itemTheme: PullDownMenuItemTheme(
                      textStyle: bodyText1.copyWith(color: Colors.black)),
                  iconColor: Colors.black,
                  onTap: () {showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            icon: TImages.deleteProduct,
                            refund: false,
                            description: AppLocalizations.of(context).translate(
                                'dialog.are_you_sure_want_to_delete_this_product'),
                            onYesPressed: () => ProductController.instance
                                .deleteProduct(product, product.vendorId));
                      });
                      
                      Navigator.pop(Get.context!);
                      }),
                       PullDownMenuItem(
                icon: Icons.language,
                      title: isArabicLocale() ? 'English' : 'العربية',
                      itemTheme: PullDownMenuItemTheme(
                          textStyle: bodyText1.copyWith(color: Colors.black)),
                      iconColor: Colors.black,
                      onTap: () async {
                        HapticFeedback.lightImpact;
                        globalRef!
                            .read(localeProvider.notifier)
                            .toggleLocale(context, globalRef!);
                      },
                    ),
              // PullDownMenuItem(
              //   icon: CupertinoIcons.add_circled,
              //   title: localizations.translate('shop.addProduct'),
              //   itemTheme: PullDownMenuItemTheme(
              //       textStyle: bodyText1.copyWith(color: Colors.black)),
              //   iconColor: Colors.black,
              //   onTap: () async {
              //     HapticFeedback.lightImpact;

              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => CreateProduct(
              //                   vendorId: vendorId,
              //                   type: '',
              //                   sectionId: 'all',
              //                 )));
              //   },
              // ),
            ],
        buttonBuilder: (context, showMenu) => CupertinoButton(
              onPressed: showMenu,
              padding: EdgeInsets.zero,
              child: TRoundedContainer(
                backgroundColor:withCircle? Colors.white: Colors.transparent,
                radius: BorderRadius.circular(400),
                // width: 28,
                // height: 28,
                enableShadow: withCircle,
                child: Center(
                  child: Icon(
                    Icons.more_vert,
                    color: TColors.black,
                    size: 25,
                  ),
                ),
              ),
            ));
  }
}
