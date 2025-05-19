import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/edit/edit_product.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/images/rounded_image.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/enums.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';
import 'package:winto/features/organization/e_commerce/utils/dialog/confirmation_dialog.dart';

class TProductItem extends StatelessWidget {
  TProductItem({super.key, required this.product});
  final ProductModel product;

  var renderOverlay = true;
  var visible = true;
  var switchLabelPosition = false;
  var extend = false.obs;
  var mini = false;
  var customDialRoot = false;
  var closeManually = false;
  var useRAnimation = true;
  var isDialOpen = ValueNotifier<bool>(false);
  var speedDialDirection =
      isArabicLocale() ? SpeedDialDirection.right : SpeedDialDirection.left;
  var buttonSize = const Size(35.0, 35.0);
  var childrenButtonSize = const Size(45.0, 45.0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   border: Border.all(color: TColors.black),
          // ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              TRoundedImage(
                imageUrl: product.images!.first,
                width: 150,
                height: 200,
                imageType: ImageType.network,
                fit: BoxFit.cover,
                borderRaduis: BorderRadius.circular(15),
              ),
              const SizedBox(width: TSizes.sm),
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                (isArabicLocale())
                                    ? product.arabicTitle
                                    : product.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontFamily: 'Tajawal-Medium'),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(children: [
                                Text(
                                  product.price.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontFamily: 'Tajawal-Medium'),
                                ),
                                Text(
                                  "SAR",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(fontFamily: 'Tajawal-Medium'),
                                ),
                                // const SizedBox(width: TSizes.spaceBtWItems * 5),
                              ]),
                              const SizedBox(
                                width: 50,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Align(
            alignment:
                isArabicLocale() ? Alignment.topLeft : Alignment.topRight,
            child: SpeedDial(
              overlayOpacity: 0,
              icon: Icons.more_vert,
              iconTheme: const IconThemeData(size: 30),
              activeIcon: Icons.close,
              spacing: 0,
              mini: mini,
              openCloseDial: isDialOpen,
              childPadding: const EdgeInsets.all(3),
              spaceBetweenChildren: 0,
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
              elevation: 0,
              animationCurve: Curves.elasticInOut,
              isOpenOnStart: false,
              // shape: customDialRoot
              //     ? const RoundedRectangleBorder()
              //     : const StadiumBorder(),
              onOpen: () {
                extend.value = true;
              },
              onClose: () {
                extend.value = false;
              },
              children: [
                SpeedDialChild(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(TImages.editIcon, color: Colors.black),
                  ),
                  onTap: () {
                    
                     EditProductController.instance.init(product);
                     Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProduct(
                                product: product,
                                vendorId: product.vendorId,
                              )));},//EditProduct
                ),
                // SpeedDialChild(
                //     elevation: 0,
                //     child: Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: Image.asset(
                //         TImages.imagePlaceholder,
                //         color: TColors.black,
                //       ),
                //     ),
                //     onTap: () =>
                //         ProductController.instance.updateProductImage(context)),
                SpeedDialChild(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      TImages.delete,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    showDialog(
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
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
