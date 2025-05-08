import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/constants/colors.dart' as TColors;
import 'package:winto/core/constants/text_styles.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/admin/presentation/pages/edit/edit_profile.dart';
import 'package:winto/features/controls/presentation/control_center.dart';
import 'package:winto/features/organization/e_commerce/features/banner/view/all/all_banners.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/all_category/all_categories.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/create_category/create_category.dart';
import 'package:winto/features/organization/e_commerce/features/excel/view/excel_terms.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/all_products_list.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/saved_products_list.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/category_list_test.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_view.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/policy_page.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';

class ControlPanelMenu extends StatelessWidget {
  const ControlPanelMenu({super.key, required this.vendorId});
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return PullDownButton(
        routeTheme: const PullDownMenuRouteTheme(
          backgroundColor: Colors.white,
        ),
        itemBuilder: (context) => [
              PullDownMenuItem(
                icon: CupertinoIcons.eye,
                title: isArabicLocale() ? 'مشاهدة متجري' : 'View my Shop',
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MarketPlaceView(
                              vendorId: vendorId, editMode: false)));
                },
              ),
              PullDownMenuItem(
                icon: CupertinoIcons.add_circled,
                title: localizations.translate('shop.addProduct'),
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateProduct(
                                vendorId: vendorId,
                                type: '',
                                sectionId: 'all',
                              )));
                },
              ),//PolicyPage
              PullDownMenuItem(
                icon: Icons.terminal,
                  title: isLocaleEn(context) ? 'manage Terms' : 'ادارة البنود',
               
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PolicyPage(vendorId: vendorId,)));
                },
              ),
               PullDownMenuItem(
                icon: Icons.save,
               title: isLocaleEn(context) ? 'Excel import' : 'استيرات اكسل',
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImportExcelPage()));
                },
              ),
              PullDownMenuItem(
                icon: Icons.category,
                title: localizations.translate('shop.categories'),
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryMobileScreen(
                                vendorId: vendorId,
                              )));
                },
              ),
              PullDownMenuItem(
                icon: CupertinoIcons.infinite,
                title: localizations.translate('shop.products'),
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductsList(
                                vendorId: vendorId,
                              )));
                },
              ),
              PullDownMenuItem(
                icon: CupertinoIcons.photo_on_rectangle,
                title: localizations.translate('shop.banners'),
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BannersMobileScreen(
                                vendorId: vendorId,
                              )));
                },
              ),
              PullDownMenuItem(
                icon: Icons.edit,
                title: isArabicLocale()
                    ? 'اعدادات الحساب'
                    : localizations.translate('Edit Profile'),
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfileActions()));
                },
              ),
              PullDownMenuItem(
                icon: Icons.settings,
                title: isArabicLocale()
                    ? 'اعدادات التطبيق'
                    : localizations.translate('App Setting'),
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ControlCenter()));
                },
              ),
              PullDownMenuItem(
                icon: Icons.category,
                title: localizations.translate('shop.categories'),
                itemTheme: PullDownMenuItemTheme(
                    onPressedBackgroundColor:
                        TColors.primary.withValues(alpha: .5),
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryListTile()));
                },
              ),
            ],
        buttonBuilder: (context, showMenu) => CupertinoButton(
              onPressed: showMenu,
              padding: EdgeInsets.zero,
              child: TRoundedContainer(
                backgroundColor: Colors.transparent,
                radius: BorderRadius.circular(400),
                width: 30,
                height: 30,
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
