import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:winto/app/data.dart';
import 'package:winto/app/providers.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/admin/presentation/widgets/profile/profile_image.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/profile_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class CustomAppBarClient extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;
  final bool isBackButtonExist;
  final bool showActionButton;
  final Function()? onBackPressed;
  final bool centerTitle;
  final double? fontSize;
  final bool showResetIcon;
  final Widget? reset;
  final bool showLogo;

  const CustomAppBarClient(
      {super.key,
      required this.title,
      this.isBackButtonExist = true,
      this.onBackPressed,
      this.centerTitle = false,
      this.showActionButton = true,
      this.fontSize,
      this.showResetIcon = false,
      this.reset,
      this.showLogo = false});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: 
        
        AppBar(
          
                
            backgroundColor: Theme.of(context).cardColor,
            toolbarHeight: 70,
            iconTheme: IconThemeData(
                color: Theme.of(context).textTheme.bodyLarge?.color),
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(title ?? '',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontSize:fontSize?? 17,
                      fontFamily: isArabicLocale() ? arabicFonts : englishFonts,
                      color: Theme.of(context).textTheme.bodyLarge?.color),
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis),
            ),
            centerTitle: true,
            excludeHeaderSemantics: true,
            titleSpacing: 0,
            elevation: 1,
            clipBehavior: Clip.none,
            shadowColor: Theme.of(context).primaryColor.withOpacity(.1),
            leadingWidth: isBackButtonExist ? 50 : 120,
            leading: isBackButtonExist
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.color
                              ?.withOpacity(.75),
                        ),
                        onPressed: () => onBackPressed != null
                            ? onBackPressed!()
                            : Navigator.pop(context)),
                  )
                : showLogo
                    ? Padding(
                        padding: const EdgeInsets.only(
                            left: TSizes.paddingSizeDefault),
                        child: SizedBox(child: Image.asset(TImages.shop)))
                    : const SizedBox()));
  }

  @override
  Size get preferredSize => Size(MediaQuery.of(Get.context!).size.width, 70);
}
