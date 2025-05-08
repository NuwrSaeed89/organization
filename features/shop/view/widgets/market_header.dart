import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/app/data.dart';
import 'package:winto/core/constants/colors.dart';
import 'package:winto/features/admin/presentation/widgets/profile/profile_image.dart';
import 'package:winto/features/nav/static_bottom_navigator.dart';
import 'package:winto/features/organization/e_commerce/features/shop/edit_field.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_managment.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_view.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu_visitor.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/follow_heart.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/social/data/firebase/user/fetch_user_map.dart';
import 'package:winto/features/social/presentation/pages/feed/wall.dart';
import 'package:winto/features/social/presentation/widgets/posts/network/display/display_image_full.dart';

Widget marketHeaderSection(String userId, bool editMode, bool isVendor) {
  bool preparingLink = false;

  return Consumer(
    builder: (context, ref, child) {
      final localizations = AppLocalizations.of(context);
      return FutureBuilder<Map<String, dynamic>?>(
        future: fetchUserMap(userId, ref),
        builder: (context, snapshot) {
          // Define the userMap! variable
          Map<String, dynamic>? userMap = snapshot.data ?? {};

          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show loading state while waiting for the data
            userMap = {
              'bannerImage': '',
              'profileImage': '',
              'name': '',
              'isVerified': false,
              'profession': '',
              'bio': '',
              'posts': 0,
              'likes': 0,
              'supports': 0,
              'uid': '',
              'organizationName': ''
            }; // Default to loading state
          } else if (snapshot.hasError) {
            // Handle error state
            return Center(
                child: Text(
                    "${localizations.translate('user_profile_top_section.error')}${snapshot.error}"));
          } else if (!snapshot.hasData || userMap.isEmpty) {
            // Handle no data state
            return Center(
                child: Text(localizations
                    .translate('user_profile_top_section.user_not_found')));
          }

          return Column(
            children: [
              Stack(alignment: Alignment.topCenter, children: [
                Container(
                  width: 100.w,
                  height: 66.h + 10,
                  color: Colors.transparent,
                ),
                if (userMap['bannerImage'] != 'loading')
                  userMap['bannerImage'] == ''
                      ? Container(
                          width: 100.w,
                          height: 66.h,
                          color: Colors.grey,
                        )
                      : Stack(
                          children: [
                            Container(
                              color: Colors.transparent,
                              height: 65.h,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  width: 100.w,
                                  height: 63.h,
                                  color: Colors.white,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(0),
                                        bottomRight: Radius.circular(0)),
                                    child: CachedNetworkImage(
                                      imageUrl: userMap['bannerImage'],
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          TShimmerEffect(
                                        width: 100.w,
                                        height: 55.h,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        width: 100.w,
                                        height: 55.h,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 17,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact;
                                  Navigator.pop(context);
                                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const StaticBottomNavigator())); 
                                },
                                child: TRoundedContainer(
                                    radius: BorderRadius.circular(50),
                                    width: 40,
                                    height: 40,
                                    enableShadow: true,
                                    backgroundColor: Colors.white,
                                    child: const Icon(
                                      CupertinoIcons.home,
                                      size: 26,
                                    )),
                              ),
                            ),
                            Positioned(
                              left: 17,
                              bottom: 0,
                              child: FollowHeart(
                                myId: userId_,
                                userId: userMap['uid'],
                                primary: primary,
                              ),
                            ),
                          ],
                        ),
                if (userMap['bannerImage'] == 'loading')
                  TShimmerEffect(
                    width: 100.w,
                    height: 60.h,
                    raduis: BorderRadius.circular(50),
                    color: Colors.grey,
                  ),
                Positioned(
                  bottom: -10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NetworkImageContainerFullSize(
                                      userMap!['profileImage'] ?? '')));
                    },
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 200,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,

                                    blurRadius: 6,
                                    offset: Offset(0, 3), // موقع الظل
                                  ),
                                ],
                              ),
                              child: UserProfileImageWidget(
                                imgUrl: userMap['profileImage'] ?? '',
                                size: 175,
                                withShadow: false,
                                allowChange: false,
                              ),
                            ),
                          ),
                        ),
                        if ((userMap['isVerified'] ?? false) == true)
                          Positioned(
                            bottom: 0,
                            left: 10,
                            right: 10,
                            child: Container(
                              width: 10,
                              decoration: const BoxDecoration(),
                              child: SvgPicture.asset(
                                  'assets/images/ecommerce/icons/verified.svg'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // Align(
                //   alignment:
                //       isArabicLocale() ? Alignment.topRight : Alignment.topLeft,
                //   // left: 12,
                //   // right: isArabicLocale() ? 12 : null,
                //   // top: isArabicLocale() ? null : 12,
                //   child: const Padding(
                //     padding: EdgeInsets.all(8.0),
                //     child: ControlPanelMenu(),
                //   ),
                // ),
                // Align(
                //   alignment:
                //       isArabicLocale() ? Alignment.topLeft : Alignment.topRight,
                //   // left: 12,
                //   // right: isArabicLocale() ? 12 : null,
                //   // top: isArabicLocale() ? null : 12,
                //   child: Padding(
                //     padding: EdgeInsets.all(12.0),
                //     child: TRoundedContainer(
                //       width: 30,
                //       height: 30,
                //       backgroundColor: Colors.white,
                //       radius: BorderRadius.circular(40),
                //       child: Center(
                //         child: Icon(
                //           Icons.share,
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const StaticBottomNavigator()));
                      },
                      child: TRoundedContainer(
                        width: 30,
                        height: 30,
                        backgroundColor: Colors.white,
                        radius: BorderRadius.circular(40),
                        child: const Center(
                          child: Icon(
                            Icons.refresh,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),

              Stack(
                children: [
                  if (isVendor)
                    Visibility(
                      visible: !editMode,
                      child: Positioned(
                        left: 0,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: () {
                            HapticFeedback.lightImpact;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPlaceManagment(
                                        vendorId: userId, editMode: true)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                'assets/images/ecommerce/icons/store.svg',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (isVendor)
                    Visibility(
                      visible: editMode,
                      child: Positioned(
                        left: 0,
                        bottom: 10,
                        child: GestureDetector(
                          onTap: () {
                           // HapticFeedback.lightImpact;

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPlaceView(
                                        vendorId: userId, editMode: false)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 18.0,
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child:
                                    const Icon(Icons.remove_red_eye_outlined)),
                          ),
                        ),
                      ),
                    ),
                  Visibility(
                    visible: editMode,
                    child: Positioned(
                      right: 0,
                      bottom: 10,
                      child: Padding(
                          padding: const EdgeInsets.only(
                            right: 18.0,
                          ),
                          child: ControlPanelMenu(
                            vendorId: userId,
                          )
                          // TRoundedContainer(
                          //   backgroundColor: Colors.white,
                          //   enableShadow: true,
                          //   width: 40,
                          //   height: 38,
                          //   radius: BorderRadius.circular(300),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(6.0),
                          //     child: Icon(Icons.settings, size: 28),
                          //   ),
                          // ),
                          ),
                    ),
                  ),
                  Visibility(
                    visible: !editMode,
                    child: Positioned(
                      right: 0,
                      bottom: 10,
                      child: Padding(
                          padding: const EdgeInsets.only(
                            right: 18.0,
                          ),
                          child: ControlPanelMenuVisitor(
                            vendorId: userId,
                            editMode: isVendor,
                          )
                          // TRoundedContainer(
                          //   backgroundColor: Colors.white,
                          //   enableShadow: true,
                          //   width: 40,
                          //   height: 38,
                          //   radius: BorderRadius.circular(300),
                          //   child: Padding(
                          //     padding: const EdgeInsets.all(6.0),
                          //     child: Icon(Icons.settings, size: 28),
                          //   ),
                          // ),
                          ),
                    ),
                  ),
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16.0,bottom: 16),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Visibility(
                              visible: editMode,
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditFieldPage(
                                            userMap!,
                                            localizations
                                                .translate('edit_profile.name'),
                                            'name',
                                            1,
                                            60,
                                            localizations.translate(
                                                'edit_profile.enter_your_name')))),
                                child: TRoundedContainer(
                                  width: 22,
                                  height: 22,
                                  enableShadow: true,
                                  radius: BorderRadius.circular(300),
                                  child: const Icon(
                                    Icons.edit,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: editMode,
                              child: const SizedBox(
                                width: 4,
                              ),
                            ),
                           Container(
                            color: Colors.transparent,
            width: 60.w,
            height: 20,

                              child:  Align(
              alignment: Alignment.center,
                                child: Text(
                                  userMap['organizationName'] ??
                                      userMap['name'] ??
                                      '',
                                      maxLines: 1,
                                                textAlign: TextAlign.center,
                                
                                  style: titilliumSemiBold.copyWith(fontSize: 18,fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // if (userMap['profession'] != null &&
              //     userMap['profession'] != '')
              //   Text(
              //     userMap['profession'],
              //     style: const TextStyle(
              //         fontSize: 13,
              //         color: Colors.black,
              //         fontFamily: 'Nunito Sans'),
              //   ),
              if (userMap['profession'] != '')
                Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    userMap['profession'] ?? '',
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: titilliumRegular.copyWith(fontSize: 15),
                  ),
                ),
              Column(
                children: [
                  const SizedBox(
                    height: 13,
                  ),
                  // Visibility(visible: true, child: SocialMediaIcons()),
                  Visibility(
                    visible: true,
                    child: Align(
                      alignment: Alignment.center,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 1,
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // address
                            if ((userMap['address'] ?? '') != '' &&
                                (userMap['isAddressVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final url =
                                        userMap!['address'].startsWith('http')
                                            ? userMap['address']
                                            : 'https://${userMap['address']}';
                                    await launchUrl(Uri.parse(url));
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/location.svg',
                                    width: 20,
                                    height: 23,
                                  ),
                                ),
                              ),
                            // Website
                            if ((userMap['website'] ?? '') != '' &&
                                (userMap['isWebsiteVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    final url =
                                        userMap!['website'].startsWith('http')
                                            ? userMap['website']
                                            : 'https://${userMap['website']}';
                                    await launchUrl(Uri.parse(url));
                                  } catch (e) {
                                    log(e.toString());
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/web.svg',
                                    width: 28,
                                    height: 28,
                                  ),
                                ),
                              ),

                            // Email
                            if ((userMap['email'] ?? '') != '' &&
                                (userMap['isEmailActionVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  final Email email = Email(
                                    body: '',
                                    subject: '',
                                    recipients: [userMap!['email']],
                                  );
                                  await FlutterEmailSender.send(email);
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/gmail.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                ),
                              ),

                            // Phone
                            if ((userMap['phone'] ?? '') != '' &&
                                (userMap['isPhoneActionVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  final url =
                                      Uri.parse('tel:${userMap!['phone']}');
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(url);
                                  } else {
                                    log('Could not launch $url');
                                  }
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/phon.svg',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              ),

                            // LinkedIn
                            if ((userMap['linkedIn'] ?? '') != '' &&
                                (userMap['isLinkedInActionVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  final url =
                                      userMap!['linkedIn'].startsWith('http')
                                          ? userMap['linkedIn']
                                          : 'https://${userMap['linkedIn']}';
                                  await launchUrl(Uri.parse(url));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/linkedin.svg',
                                    width: 23,
                                    height: 23,
                                  ),
                                ),
                              ),

                            // YouTube
                            if ((userMap['youtube'] ?? '') != '' &&
                                (userMap['isYoutubeActionVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  final url =
                                      userMap!['youtube'].startsWith('http')
                                          ? userMap['youtube']
                                          : 'https://${userMap['youtube']}';
                                  await launchUrl(Uri.parse(url));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/youtube.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                ),
                              ),

                            // Facebook
                            if ((userMap['facebook'] ?? '') != '' &&
                                (userMap['isFacebookActionVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  final url =
                                      userMap!['facebook'].startsWith('http')
                                          ? userMap['facebook']
                                          : 'https://${userMap['facebook']}';
                                  await launchUrl(Uri.parse(url));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/facebook.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                ),
                              ),

                            // Instagram
                            if ((userMap['instagram'] ?? '') != '' &&
                                (userMap['isInstagramActionVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  final url =
                                      userMap!['instagram'].startsWith('http')
                                          ? userMap['instagram']
                                          : 'https://${userMap['instagram']}';
                                  await launchUrl(Uri.parse(url));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/insta.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                ),
                              ),

                            // X (Twitter)
                            if ((userMap['x'] ?? '') != '' &&
                                (userMap['isXActionVisible'] ?? false))
                              GestureDetector(
                                onTap: () async {
                                  final url = userMap!['x'].startsWith('http')
                                      ? userMap['x']
                                      : 'https://${userMap['x']}';
                                  await launchUrl(Uri.parse(url));
                                },
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: SvgPicture.asset(
                                    'assets/images/ecommerce/icons/x.svg',
                                    width: 26,
                                    height: 26,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  if (userMap['bio'] != '')
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        userMap['bio'],
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.ltr,
                        style: titilliumRegular.copyWith(fontSize: 16),
                      ),
                    ),
                ],
              ),
              /* if (!((userMap['phone'] ?? '') != '' &&
                          (userMap['isPhoneActionVisible'] ?? false)) &&
                      !((userMap['email'] ?? '') != '' &&
                          (userMap['isEmailActionVisible'] ?? false)))
                    if ((userMap['website'] ?? '') != '' &&
                        (userMap['isWebsiteVisible'] ?? false))
                      Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          GestureDetector(
                            onTap: () async {
                              try {
                                final url =
                                    userMap!['website'].startsWith('http')
                                        ? userMap['website']
                                        : 'https://${userMap['website']}';
                                await launchUrl(Uri.parse(url));
                              } catch (e) {
                                log(e.toString());
                              }
                            },
                            child: SizedBox(
                              width: 70.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/link.svg',
                                    color: primary,
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    child: Text(
                                      userMap['website'],
                                      overflow: TextOverflow.ellipsis,
                                      style: bodyText1.copyWith(color: primary),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ), */

              const Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8),
                child: Divider(
                  thickness: 1.5,
                ),
              )
            ],
          );
        },
      );
    },
  );
}
