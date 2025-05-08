import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/constants/colors.dart' as TColors;
import 'package:winto/core/constants/text_styles.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_managment.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_view.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';

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
                icon: Icons.share,
                title: isArabicLocale()
                    ? 'مشاركة'
                    : localizations.translate('Share'),
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () {},
              ),
              PullDownMenuItem(
                icon: Icons.info,
                title: isArabicLocale() ? 'من نحن' : 'About Us',
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () {},
              ),
              PullDownMenuItem(
                  icon: Icons.people,
                  title: isArabicLocale() ? 'فريقنا' : 'Team',
                  itemTheme: PullDownMenuItemTheme(
                      textStyle: bodyText1.copyWith(color: Colors.black)),
                  iconColor: Colors.black,
                  onTap: () {}),
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
