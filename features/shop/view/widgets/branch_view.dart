import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/profile_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/category_tab.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/tabbar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/helpers/helper_functions.dart';

Widget branchesView(String userId, bool editMode, BuildContext context) {
  return FutureBuilder(
      future: CategoryController.instance
          .getCategoryOfUser(userId), // function where you call your api
      builder: (BuildContext context, snapshot) {
        // AsyncSnapshot<Your object type>
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Please wait its loading...'));
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              AppLocalizations.of(context)
                  .translate('session.someThinggowrong'),
              style: robotoMedium,
            ),
          );
        }

        final categories = snapshot.data;
        if (categories!.isEmpty) {
          return const SizedBox(child: Center(child: Text("comming soon")));
        }
        return DefaultTabController(
          length: categories.length,
          child: Column(
            children: <Widget>[
              // HeadSection(),
              // const TPromoSlider(),
              TTabbar(
                tabs: categories
                    .map((category) => Tab(
                            child: Text(
                          isLocaleEn(context)
                              ? category.name
                              : category.arabicName,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontFamily: isLocaleEn(context)
                                      ? englishFonts
                                      : arabicFonts),
                        )))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                    children: categories
                        .map((category) => TCategoryTab(
                              category: category,
                              editMode: userId ==
                                  FirebaseAuth.instance.currentUser!.uid,
                              userId: userId,
                            ))
                        .toList()),
              ),
            ],
          ),
        );
      });
}
