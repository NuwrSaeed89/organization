import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/app/data.dart';
import 'package:winto/app/providers.dart';
import 'package:winto/core/constants/colors.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/admin/data/utils/user_images.dart';
import 'package:winto/features/admin/presentation/widgets/profile/profile_image.dart';
import 'package:winto/features/nav/static_bottom_navigator.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/profile_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/edit_field.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_managment.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/market_place_view.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu_visitor.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/follow_heart.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/constant.dart';
import 'package:winto/features/organization/e_commerce/utils/organization_images.dart';
import 'package:winto/features/social/data/firebase/user/fetch_user_map.dart';
import 'package:winto/features/social/presentation/pages/feed/wall.dart';
import 'package:winto/features/social/presentation/pages/user/view_profile.dart';
import 'package:winto/features/social/presentation/widgets/posts/network/display/display_image_full.dart';

Widget marketHeaderSection(String userId, bool editMode, bool isVendor) {
  bool preparingLink = false;

  return Consumer(
    builder: (context, ref, child) {
      var user = ProfileController.instance.vendorData.value;
      print("Profile is is ${user.bio}");
      final localizations = AppLocalizations.of(context);
      return 
      FutureBuilder<Map<String, dynamic>?>(
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
              'organizationName': '',
               'organizationCover':'',
               'organizationLogo':''
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

          return
           Column(
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
                              height: 67.h,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: GestureDetector(
onTap: ()  { if( editMode) {

      uploadorganizationBannerImageAndSaveToFirestore(
                              context, ref); 
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPlaceManagment(
                                        vendorId: userId, editMode: true)));



                    }
                    else
                    {
 Navigator.push(  context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NetworkImageContainerFullSize(
                                     userMap!['organizationCover'] ??  userMap['bannerImage'] ?? '')));
                    }
                     
                    },



                                  child: Container(
                                    width: 100.w,
                                    height: 63.h,
                                   
                                    child: 
                                    userMap['organizationCover']=='loading'?
                                    TShimmerEffect(width: 100.w, height: 63.h):
                                    
                                     ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0)),
                                      child: 
                                       CachedNetworkImage(
                                          imageUrl: userMap['organizationCover']??userMap['bannerImage'],
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
                            ),
                            Positioned(
                              right: 15,
                              bottom: 21,
                              child: GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact;
                                   Navigator.pop(context);
                                    globalRef!
                                        .read(
                                            currentScreenIndexProvider.notifier)
                                        .state = 3;
// Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
                                    // builder: (context) => ViewSocialProfile(
                                // userId)));
                                },
                                child: TRoundedContainer(
                                    radius: BorderRadius.circular(50),
                                    width: 37,
                                    height: 37,
                                   enableShadow: true,
                                   // backgroundColor: Colors.transparent,
                                    child:
                                     Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: const Image(image: AssetImage('assets/images/logo.png'),width: 20,height: 20,),
                                    )
                                   
                               ) ),
                            ),
                            Positioned(
                              left: 15,
                              bottom: 20,
                              child:  editMode?
                              
                              Column(
                                     mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    verticalDirection:VerticalDirection.down,
                                children: [
                                  TRoundedContainer(
                                                    width: 34,
                                                    height: 34,
                                                    radius: BorderRadius.circular(300),
                                                   enableShadow: true,
                                                   
                                                    child:const  Center(
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(0),
                                                        child:
                                                            const Icon(CupertinoIcons.heart,
                                  // : CupertinoIcons.heart,
                                  // color: const Color(0xFFFF5050),
                                  color: Colors.black,
                                  size: 23)
                                                           
                                                      ),
                                                    ),
                                                  ),
                                                   SizedBox(height: 4,),
                                    Visibility(
                                      visible: false,
                                      child: Text(
                                      userMap['likes'].toString(),
                                      style: titilliumBold.copyWith(fontFamily: numberFonts),
                                                                        ),
                                    ),
                                ],
                              ): Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                verticalDirection:VerticalDirection.down,
                                children: [
                                  FollowHeart(
                                                  myId: userId_,
                                                  userId: userMap['uid'],
                                                  primary: primary,
                                                ),
                                                SizedBox(height: 4,),
                                                Visibility(
                                                  visible: false,
                                                  child: Text(
                                                  userMap['likes'].toString(),
                                                  style: titilliumBold.copyWith(fontFamily: numberFonts),
                                                                                                ),
                                                ),
                                ],
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
                    onTap: ()  { if( editMode) {
      uploadLogoAndSaveToFirestore(
                              context, ref);   
                               Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MarketPlaceManagment(
                                        vendorId: userId, editMode: true)));
                    }
                    else
                    {
 Navigator.push(  context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  NetworkImageContainerFullSize(
                                      userMap!['organizationLogo'] ?? userMap!['profileImage'] ?? '')));
                    }
                     
                    },
                    child:   Container(
                            color: Colors.transparent,
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
                                    width: 3,
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
                                child:  userMap['organizationLogo']=='loading'?
                                    TShimmerEffect(width: 175, height: 175,raduis: BorderRadius.circular(300),):
                                     UserProfileImageWidget(
                                  imgUrl:       userMap['organizationLogo']?? userMap['profileImage'] ?? '',//
                                  size: 175,
                                  withShadow: false,
                                  allowChange: true,
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
                ),
          
                
              ]),
if(!editMode) Container(
  color: Colors.transparent,
  height: 10,),
              Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    if (isVendor)
                      Visibility(
                        visible: !editMode,
                        child: Positioned(
                          left: 13,
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
                                vertical: 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Icon(Icons.settings_rounded)
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (isVendor)
                      Visibility(
                        visible: editMode,
                        child: Positioned(
                          left: 13,
                          bottom: 13,
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
                                padding: const EdgeInsets.symmetric(
                                vertical: 10,
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
                       right: 13,
                          bottom: 13,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                                vertical: 10,   ),
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
                        right: 12,
                          bottom: 10,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10,   ),
                            child: ControlPanelMenuVisitor(
                              vendorId: userId,
                              editMode: isVendor,
                            )
                           
                            ),
                      ),
                    ),
                    Center(
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0,bottom: 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             
                            
                             Column(
                              mainAxisSize: MainAxisSize.min,
                               children: [
                                
                                 Visibility(
                  visible: editMode,
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditFieldPage(
                  userMap!,
                  isArabicLocale()? "اسم مشروعك" :"Organization Name",
                  'organizationName',
                  1,
                  60,
                  isArabicLocale()? "ادخل اسم مشروعك" :"Enter Your Organization Name"))),
                    child: TRoundedContainer(
                     width: 28,
                     height: 28,
                     //showBorder: true,
                      enableShadow: true,
                      radius: BorderRadius.circular(300),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                               ),
                
                                 Container(
                                  color: Colors.transparent,
                                             width: 60.w,
                                             height: 45,
                                 
                                    child:  Align(
                                               alignment: Alignment.topCenter,
                                      child: Text(
                                        userMap['organizationName'] ??
                                            userMap['name'] ??
                                            '',
                                            maxLines: 2,
                                                      textAlign: TextAlign.center,
                                      
                                        style: titilliumSemiBold.copyWith(fontSize: 18,fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                  ),
                              
                              
                              
                               ],
                             ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                   Container(
                    color: Colors.transparent,
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
                                    width: 16,
                                    height: 16,
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

               Container(
                    color: Colors.transparent,
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

     if (editMode) const Padding(
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
