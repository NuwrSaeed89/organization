import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/core/constants/text_styles.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/core/utils/dialogs/reusable_alert_dialog.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/favorite_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/edit/edit_product.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';

class ControlPanelBlackProducttype2 extends StatelessWidget {
   ControlPanelBlackProducttype2(
      {super.key, required this.vendorId, required this.product,this.withCircle=false, required this.editMode});
  final String vendorId;
  final bool editMode;
  final ProductModel product;
  bool withCircle;
  @override
  Widget build(BuildContext context) {
  var savController = SavedProductsController.instance;
  var save = savController.isSaved(product.id).obs;
 var controller = FavoriteProductsController.instance;
  //  RxBool like = false.obs;
  // var like.value = controller.isSaved(product.id).obs;
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
     SpeedDialDirection.left ;//: SpeedDialDirection.right;
  var buttonSize = const Size(30.0, 30.0);
  var childrenButtonSize = const Size(40.0, 40.0);
   
 
    var localizations = AppLocalizations.of(context);
    return
    
     Padding(
          padding: const EdgeInsets.all(4.0),
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
              childPadding: const EdgeInsets.all(5),
              spaceBetweenChildren: 0,
              buttonSize: buttonSize,
              childrenButtonSize: childrenButtonSize,
              visible: visible,
              direction: speedDialDirection,
              switchLabelPosition: switchLabelPosition,
              closeManually: false,
              renderOverlay: renderOverlay,
              useRotationAnimation: useRAnimation,
              backgroundColor: Colors.black.withValues(alpha: .7),
             // activeBackgroundColor:  Colors.black.withValues(alpha: .3),

              foregroundColor: Colors.white,
              elevation:0 ,
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
             if(editMode)   SpeedDialChild(
                  elevation: 0,
                  child: 
                     TRoundedContainer(
                      radius: BorderRadius.circular(300),
                  backgroundColor:Colors.black.withValues(alpha:.7),
                       child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Image.asset(TImages.editIcon, color: Colors.white,width:22,height: 22,),
                                           ),
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
              
               if(editMode)      SpeedDialChild(
                  elevation: 0,
                  child:  TRoundedContainer(
                      radius: BorderRadius.circular(300),
                  backgroundColor:Colors.black.withValues(alpha:.7),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        TImages.delete,
                        color: Colors.white,width: 22,height: 22
                      ),
                    ),
                  ),
                  onTap: ()  {
                     ReusableAlertDialog.show(
              context: context,
              title: isArabicLocale() ? 'حذف العنصر' : 'Delete Item',
              content: isArabicLocale()
                  ? 'هل أنت متأكد أنك تريد حذف هذا العنصر؟'
                  : 'Are you sure you want to delete this product ?',
              onConfirm: () async  {

                           await  ProductController.instance
                                 .deleteProduct(product, product.vendorId, false);
                             
           

                
              },
            );}
                ),


     if(!editMode)  SpeedDialChild(
                  elevation: 0,
                  child: 
                    TRoundedContainer(
                        width: 30,
                    height: 30,
                      radius: BorderRadius.circular(300),
                  backgroundColor:Colors.black.withValues(alpha:.7),
                       child: Obx(
                                 () => Icon( !save.value ?Icons.bookmark_border :Icons.bookmark_outlined, size:18, color: Colors.white,),
                            ),
                     ),
                  
                  onTap: () {
        if (save.value) {
          savController.removeProduct(product.id);
          save.value = !save.value;
        } else {
          savController.saveProduct(product);
          save.value = !save.value;
        }
      },//EditProduct
                ),
   if(!editMode)   SpeedDialChild(
                  elevation: 0,
                  child: TRoundedContainer(
                    width: 30,
                    height: 30,
                      radius: BorderRadius.circular(300),
                  backgroundColor:Colors.black.withValues(alpha:.7),
                    child: Center(
                      child: Obx(
                      () => !controller.isSaved(product.id)
                          ?  Icon(CupertinoIcons.heart,
                              // : CupertinoIcons.heart,
                              // color: const Color(0xFFFF5050),
                              color: Colors.white,
                              size: 20)
                          :  Icon(CupertinoIcons.heart_fill,
                              // : CupertinoIcons.heart,
                              // color: const Color(0xFFFF5050),
                              color: Colors.red,
                              size: 20),
                                      ),
                    ),
                  ),
                     
                  
               
                    
                     onTap: () {
                       var like = controller.isSaved(product.id).obs;
 if (like.value) {
          controller.removeProduct(product.id);
          like.value = !like.value;
        } else {
          controller.saveProduct(product);
          like.value = !like.value;
        }
      },//EditProduct
                ),
              


              ],
            ),
          ),
        )
    ;
  }
}
