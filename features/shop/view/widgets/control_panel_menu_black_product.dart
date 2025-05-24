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
import 'package:winto/core/utils/dialogs/reusable_alert_dialog.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/add/add_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/edit/edit_product.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/widgets/favorite_widget.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/dialog/confirmation_dialog.dart';
import 'package:winto/main.dart';

class ControlPanelBlackProduct extends StatelessWidget {
   ControlPanelBlackProduct(
      {super.key, required this.vendorId, required this.product,this.withCircle=false, required this.editMode, this.iconColor =Colors.white});
  final String vendorId;
  final bool editMode;
  Color iconColor;
  final ProductModel product;
  bool withCircle;
  @override
  Widget build(BuildContext context) {
     var savController = SavedProductsController.instance;
    var save = savController.isSaved(product.id).obs;
    var localizations = AppLocalizations.of(context);
    return
    
    
     PullDownButton(
      
        routeTheme: const PullDownMenuRouteTheme(
          backgroundColor: Colors.white,
        ),
        itemBuilder: (context) => [

         if(!editMode) PullDownMenuItem(
        
             icon: Icons.favorite,
                title:
                    isLocaleEn(context) ? 'Like' : 'أعجبني',
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                
                },
              ),
         if(!editMode)   PullDownMenuItem(
             icon: Icons.bookmark,
                title:
                         isLocaleEn(context) ? 'حفظ' : 'Save',
                itemTheme: PullDownMenuItemTheme(
                    textStyle: bodyText1.copyWith(color: Colors.black)),
                iconColor: Colors.black,
                onTap: () async {
                 if (save.value) {
          savController.removeProduct(product.id);
          save.value = !save.value;
        } else {
          savController.saveProduct(product);
          save.value = !save.value;
        }
                },
              ),

     if(editMode)  PullDownMenuItem(
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
   if(editMode)     PullDownMenuItem(
                  icon: Icons.delete,
                  title: isLocaleEn(context)
                      ? 'Delete this item'
                      : 'حذف هذا العنصر',
                  itemTheme: PullDownMenuItemTheme(
                      textStyle: bodyText1.copyWith(color: Colors.black)),
                  iconColor: Colors.black,
                   onTap: () async {
                     ReusableAlertDialog.show(
              context: context,
              title: isArabicLocale() ? 'حذف العنصر' : 'Delete Item',
              content: isArabicLocale()
                  ? 'هل أنت متأكد أنك تريد حذف هذا العنصر؟'
                  : 'Are you sure you want to delete this product ?',
              onConfirm: () async {
             ProductController.instance
                                 .deleteProduct(product, product.vendorId,true);
                
              },
            );}),
           
            ],





//////////////
/// TRoundedContainer(
                  




            ////////////
        buttonBuilder: (context, showMenu) => CupertinoButton(
          
          padding: EdgeInsets.zero,
              onPressed: showMenu,
            
              child: TRoundedContainer(
                backgroundColor:withCircle? Colors.black.withValues(alpha: .5): Colors.transparent,
                radius: BorderRadius.circular(400),
                width: 28,
                height: 28,
                enableShadow: withCircle,
                child: Center(
                  child: Icon(
                    Icons.more_vert,
                    color: iconColor,
                    size: 22,
                  ),
                ),
              ),
            ));
  }
}
