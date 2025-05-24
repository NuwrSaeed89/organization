import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/app/data.dart';
import 'package:winto/core/constants/colors.dart' as TColors;
import 'package:winto/core/constants/text_styles.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/nav/static_bottom_navigator.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/favorite_products_list.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/saved_products_list.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_managment.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_view.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/seller.info.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/main.dart';

class ControlPanelMenuVisitor extends StatelessWidget {
  const ControlPanelMenuVisitor(
      {super.key, required this.editMode, required this.vendorId});
  final bool editMode;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return PullDownButton(
        routeTheme: const PullDownMenuRouteTheme(
          backgroundColor: Colors.white,
        ),
        itemBuilder: (context) => [
              if (editMode)
                PullDownMenuItem(
                  icon: Icons.settings,
                  title: isArabicLocale() ? 'ادارة المتجر' : 'Manage the Store',
                  itemTheme: PullDownMenuItemTheme(
                      textStyle: bodyText1.copyWith(color: Colors.black)),
                  iconColor: Colors.black,
                  onTap: () {
                    HapticFeedback.lightImpact;

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MarketPlaceManagment(
                                vendorId: vendorId, editMode: true)));
                  },
                ),
                   PullDownMenuItem(
                icon: Icons.favorite,
                title: isArabicLocale()
                    ? 'المفضلة'
                    : "Favorite List",
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                 onTap: () =>  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FavoriteProductsPage(
                             ))),
              ),
              PullDownMenuItem(
                icon: Icons.bookmarks,
                title: isArabicLocale()
                    ? 'قائمة الحفظ'
                    : "Save List",
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                 onTap: () =>  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SavedProductsPage(
                             ))),
              ),
              
              PullDownMenuItem(
                icon:Icons.language,
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
              //SavedProductsPage
              PullDownMenuItem(
                icon: Icons.info,
                title: isArabicLocale() ? 'سياسة المتجر' : 'Our Policies',
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () =>  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PolicyDisplayPage(
                                vendorId: vendorId))),

              ),
               PullDownMenuItem(
                icon: CupertinoIcons.reply,
                title: isArabicLocale()
                    ? 'خروج'
                    : "Exit",
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                  HapticFeedback.lightImpact;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StaticBottomNavigator()));
                },
              ),
              
              //
              // PullDownMenuItem(
              //     icon: Icons.people,
              //     title: isArabicLocale() ? 'فريقنا' : 'Team',
              //     itemTheme: PullDownMenuItemTheme(
              //         textStyle: bodyText1.copyWith(color: Colors.black)),
              //     iconColor: Colors.black,
              //     onTap: () {}),
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
