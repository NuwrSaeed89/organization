import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // لاستخدام ردود الفعل اللمسية
import 'package:get/get.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/edit_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/favorite_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/features/product/views/edit/edit_product.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/image_strings.dart';
import 'package:winto/features/organization/e_commerce/utils/dialog/confirmation_dialog.dart';

class FloatingButtonsClientController extends GetxController {
ProductModel product = ProductModel.empty();
   var savedController = SavedProductsController.instance;
   var favoriteController = FavoriteProductsController.instance;
   
  OverlayEntry? overlayEntry;
  var isEditabel=false;
  // متغير لمتابعة موقع الإصبع (سيُحدث أثناء السحب)
  Rxn<Offset> currentDragPosition = Rxn<Offset>();

  // عتبة الكشف (بالبكسل) لتحديد مدى قرب الإصبع من مركز أيقونة معينة
  final double iconActivationThreshold = 50.0;
  // قائمة لتخزين مراكز الأيقونات بعد حسابها
  final List<Offset> iconCenters = [];

  // بيانات الأيقونات؛ هنا "حفظ" تُستخدم لأيقونة الإعجاب (like)
  final List<Map<String, dynamic>> iconsData = [
      {"icon": Icons.close, "label": "close"},
    {"icon": Icons.favorite, "label": "like"},
    {"icon": Icons.bookmark, "label": "save"},
  
    // {"icon": Icons.edit, "label": "edit"},
    // {"icon": Icons.delete, "label": "delete"},
  ];
  //   final List<Map<String, dynamic>> iconsDataClient = [
  //   {"icon": Icons.favorite, "label": "like"},
  //   {"icon": Icons.bookmark, "label": "save"},
  //   {"icon": Icons.close, "label": "close"},

  // ];

  bool _actionTriggered = false;
var isLike=false.obs;
  int _lastHoveredIndex = -1;

  // نقوم بتخزين موقع الضغط الأولي لاستخدامه في رسم دائرة شفافة
  Offset? pressPosition;
 //var iconsDate= isEditabel ? iconsDataVendor:iconsDataClient;
  /// تعرض هذه الدالة القائمة العائمة (Overlay)
  /// مع طبقة تعتيم ودائرة شفافة في موقع الضغط.
  /// يتم حساب زاوية بدء عرض الأيقونات ديناميكيًا بناءً على مكان الإصبع.
  /// [productIsFavorite] هي حالة المنتج (مفضلة أم لا).
  void showFloatingButtons(BuildContext context, Offset position,
      {bool productIsFavorite = false}) {
         var saved = savedController.isSaved(product.id).obs;

   
    removeFloatingButtons();
    iconCenters.clear();
    _actionTriggered = false;
    var isFavorite = false.obs;
    _lastHoveredIndex = -1;
    pressPosition = position;
    currentDragPosition.value = position; // تحديث أولي لموضع الإصبع

 final mediaQuery = MediaQuery.of(context);
final screenSize = mediaQuery.size;
final centerX = screenSize.width / 2;
double baseAngle=-pi / 2;
if (pressPosition!.dx < centerX * 0.3) {
  baseAngle = 0; // القائمة تظهر على يمين الإصبع عندما يكون الضغط في أقصى اليسار
} 
if (pressPosition!.dx > centerX * 0.7) {
  baseAngle = pi; // القائمة تظهر على يمين الإصبع عندما يكون الضغط في أقصى اليسار
}
final spread = pi / 2;
final startAngle = baseAngle - spread / 2;
final endAngle = baseAngle + spread / 2;
double radius = 90.0;

    overlayEntry = OverlayEntry(
      builder: (context) {
            //  var iconsData=isEditabel ? iconsDataVendor:iconsDataClient;
        // نستخدم IgnorePointer لكي لا تُعترض طبقة الـ Overlay أحداث اللمس،
        // وهذا يسمح للـ GestureDetector في شاشة المنتجات التقاطها.
        return IgnorePointer(
          child: Obx(() {
            // اختبار الأيقونة التي يمر فوقها الإصبع لتفعيل رد الفعل اللمسي.
            int currentHovered = _getSelectedIconIndex();
            if (currentHovered != _lastHoveredIndex && currentHovered != -1) {
              HapticFeedback.lightImpact();
              _lastHoveredIndex = currentHovered;
            }
            return Stack(
              children: [
                // طبقة تعتيم تغطي الشاشة.
                Container(color: Colors.black.withValues(alpha:0.2)),
                // رسم الدائرة الشفافة في موقع الضغط.
                if (pressPosition != null)
                   Positioned(
                    left: pressPosition!.dx ,
                    top: pressPosition!.dy ,
                    child: TRoundedContainer(
                      width: 50,
                      height: 50,
                      radius: BorderRadius.circular(300),
                      showBorder: true,
                     borderColor: Colors.grey.withValues(alpha: .5),
                      borderWidth: 4,
                      backgroundColor: Colors.transparent,
                   
                     
                    ),
                  ),
                // رسم أيقونات القائمة.
                ...List.generate(iconsData.length, (index) {
                  // نحسب زاوية ظهور الأيقونة بناءً على الزاوية الأساسية وانتشارها.
                  double iconAngle = startAngle +
                      index *
                          ((endAngle - startAngle) / (iconsData.length - 1));
                  double dx = radius * cos(iconAngle);
                  double dy = radius * sin(iconAngle);
                  Offset iconCenter = pressPosition! + Offset(dx, dy);
                  if (iconCenters.length < iconsData.length) {
                    iconCenters.add(iconCenter);
                  } else {
                    iconCenters[index] = iconCenter;
                  }
                  // تحديد اللون وحجم الأيقونة بناءً على قرب الإصبع منها.
                  Color defaultColor;
                  Color hoverColor;
                 // color iconColor;
                  switch (iconsData[index]["label"]) {
                    case "like":
                      defaultColor = favoriteController.isSaved(product.id)  ? Colors.red : Colors.black;
                     // hoverColor = Colors.redAccent;
                      hoverColor = Colors.grey.withValues(alpha: .5);
                      break;
                    case "save":
                      defaultColor = saved.value ? Colors.blue : Colors.black;
                     // defaultColor = Colors.white;
                     
                       hoverColor = Colors.grey.withValues(alpha: .5);
                     // hoverColor = Colors.green;
                      break;
                  //   case "edit":
                  //     defaultColor = Colors.white;
                  //       hoverColor = Colors.grey.withValues(alpha: .5);
                  //  //   hoverColor = Colors.green;
                  //     break;
                  //   case "delete":
                  //     defaultColor = Colors.white;
                  //       hoverColor = Colors.grey.withValues(alpha: .5);
                  //   //  hoverColor = Colors.red;
                  //     break;
                    default:
                      defaultColor = Colors.black;
                      hoverColor = Colors.grey;
                  }
                  Color bgColor = defaultColor;
                  double scale = 1.0;
                  if (currentDragPosition.value != null) {
                    double distance =
                        (currentDragPosition.value! - iconCenter).distance;
                    if (distance <= iconActivationThreshold) {
                      bgColor = hoverColor;
                      scale = 1.5;
                    }
                  }
                  // إذا كانت الأيقونة "حفظ" تقوم بتبديل الرمز بحسب حالة المفضلة.
                  IconData iconData = iconsData[index]["label"] == "save"
                      ? (saved.value ? Icons.bookmark : Icons.bookmark_border)
                      : iconsData[index]["label"] == "like"
                      ? (favoriteController.isSaved(product.id) ? Icons.favorite : Icons.favorite_border)


                      : iconsData[index]["icon"];


                  return Positioned(
                    left: iconCenter.dx - 20,
                    top: iconCenter.dy - 20,
                    child: AnimatedScale(
                      scale: scale,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: FloatingActionButton(
                        mini: true,
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child: Icon(iconData, color:defaultColor),
                      ),
                    ),
                  );
                }),
              ],
            );
          }),
        );
      },
    );
    Overlay.of(context).insert(overlayEntry!);
  }

  /// تقوم هذه الدالة بتحديث موقع الإصبع
  void updatePosition(Offset pos) {
    currentDragPosition.value = pos;
  }

  /// تُعيد _getSelectedIconIndex الفهرس الخاص بالأيقونة التي يقع عنها الإصبع ضمن العتبة
  int _getSelectedIconIndex() {
    if (currentDragPosition.value == null) return -1;
    for (int i = 0; i < iconCenters.length; i++) {
      if ((currentDragPosition.value! - iconCenters[i]).distance <=
          iconActivationThreshold) {
        return i;
      }
    }
    return -1;
  }

  /// عند تحرير الإصبع تُعالج عملية الاختيار (إذا وُجدت أيقونة تحت الإصبع)
  void processSelection() {
     // var iconsData=isEditabel ? iconsDataVendor:iconsDataClient;
    if (!_actionTriggered) {
      int selectedIndex = _getSelectedIconIndex();
      if (selectedIndex != -1) {
        _actionTriggered = true;
        if (iconsData[selectedIndex]["label"] == "like") {
       isLike.value=!isLike.value;
        }
        performAction(iconsData[selectedIndex]["label"]);
      }
    }
  }

 void performAction(String label) {

 switch (label) {
   case 'like':
   var like= favoriteController.isSaved(product.id);
     if (like) {
         favoriteController.removeProduct(product.id);
        
        } else {
          favoriteController.saveProduct(product);
        }
        break;
  
   case 'delete':
      showDialog(
                      context: Get.context!,
                      builder: (BuildContext context) {
                        return ConfirmationDialog(
                            icon: TImages.delete,
                            refund: false,
                            description: AppLocalizations.of(context).translate(
                                'dialog.are_you_sure_want_to_delete_this_product'),
                            onYesPressed: () => ProductController.instance
                                .deleteProduct(product, product.vendorId,false));
                      });
                      break;
     
       case 'save':
      var save= SavedProductsController.instance.isSaved(product.id);
     if (save) {
          SavedProductsController.instance.removeProduct(product.id);
        
        } else {
          SavedProductsController.instance.saveProduct(product);
        }
        break;
    
  
      case 'close':
      removeFloatingButtons();
     break;
      default:
      removeFloatingButtons();
        return ;// القيمة الافتراضية إذا لم يكن المدخل صحيحاً
    }


   // Get.snackbar("إجراء", "تم تنفيذ: $label", snackPosition: SnackPosition.BOTTOM);
  }



  void removeFloatingButtons() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}

