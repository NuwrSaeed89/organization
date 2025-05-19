import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/saved_product_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class FloatingButtonsClientController extends GetxController {
  OverlayEntry? overlayEntry;
  Rxn<Offset> currentDragPosition = Rxn<Offset>();
ProductModel p=ProductModel.empty();
  // زيادة العتبة لتوسيع منطقة التفاعل (من 30 إلى 50 بكسل)
  final double iconActivationThreshold = 20.0;

  // قائمة لتخزين مراكز الأيقونات
  final List<Offset> iconCenters = [];

  // بيانات الأيقونات (الأيقونة والتسمية)
  final List<Map<String, dynamic>> iconsData = [
     {"icon": Icons.close, "label": "close"},
    {"icon": Icons.favorite, "label": "like"},
   // {"icon": Icons.share, "label": "share"},
     {"icon": Icons.bookmark_border, "label": "Save"},
   
  ];
bool isLike=false;
  // متغير لضمان تنفيذ الحدث مرة واحدة سواء بالضغط أو بالسحب
  bool _actionTriggered = false;

  /// عرض التراكب مع الأيقونات على شكل قوس نصف دائري (من زاوية 20 إلى 110 بعد إضافة offset بقدر 90)
  void showFloatingButtons(BuildContext context, Offset position) {
    removeFloatingButtons();
    iconCenters.clear();
    _actionTriggered = false;

    double radius = 60.0;
    double startAngleDeg = 60;
    double endAngleDeg = 160;
    double baseOffsetDeg = 90;
    double startAngle = (startAngleDeg + baseOffsetDeg) * pi / 180;
    double endAngle = (endAngleDeg + baseOffsetDeg) * pi / 180;

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Listener(
          behavior: HitTestBehavior.opaque, // حساسية أكبر لجميع أحداث اللمس
          onPointerMove: (details) {
            currentDragPosition.value = details.position;
          },
          onPointerUp: (event) {
            if (!_actionTriggered) {
              int selectedIndex = _getSelectedIconIndex();
              if (selectedIndex != -1) {
                _actionTriggered = true;
                performAction(iconsData[selectedIndex]["label"]);
              }
            }
            removeFloatingButtons();
          },
          child: Obx(() {
            return Stack(
              children: List.generate(iconsData.length, (index) {
                // توزيع الأيقونات بالتساوي على القوس المحدد
                double angle = startAngle +
                    index * ((endAngle - startAngle) / (iconsData.length - 1));
                double dx = radius * cos(angle);
                double dy = radius * sin(angle);
                Offset iconCenter = position + Offset(dx, dy);
                if (iconCenters.length < iconsData.length) {
                  iconCenters.add(iconCenter);
                } else {
                  iconCenters[index] = iconCenter;
                }
                // ضبط اللون والحجم الافتراضي للأيقونة
                Color bgColor = Colors.white;
                double scale = 1.0;
                if (currentDragPosition.value != null) {
                  double distance =
                      (currentDragPosition.value! - iconCenter).distance;
                  if (distance <= iconActivationThreshold) {
                    bgColor = TColors.primary;
                    scale = 1.5;
                  }
                }
                return Positioned(
                  left: iconCenter.dx - 20, // يتم تعويض نصف حجم الزر (40 بكسل لزر mini)
                  top: iconCenter.dy - 20,
                  child: Transform.scale(
                    scale: scale,
                    child: FloatingActionButton(
                      mini: true,
                      onPressed: () {
                        if (!_actionTriggered) {
                          _actionTriggered = true;
                          performAction(iconsData[index]["label"]);
                        }
                        removeFloatingButtons();
                      },
                      child: Icon(
                        iconsData[index]["icon"],
                        color: Colors.black,
                      ),
                      backgroundColor: bgColor,
                    ),
                  ),
                );
              }),
            );
          }),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry!);

    // إزالة التراكب تلقائيًا بعد 5 ثوانٍ إذا لم يتم التفاعل
    Timer(Duration(seconds: 5), () {
      if (overlayEntry != null) removeFloatingButtons();
    });
  }

  /// تحديد الفهرس (index) الخاص بالأيقونة التي تقع ضمن عتبة التفاعل
  int _getSelectedIconIndex() {
    if (currentDragPosition.value == null) return -1;
    for (int i = 0; i < iconCenters.length; i++) {
      if ((currentDragPosition.value! - iconCenters[i]).distance <= iconActivationThreshold) {
        return i;
      }
    }
    return -1;
  }

  /// تنفيذ الحدث المناسب بناءً على التسمية (يمكن استبداله بالأحداث المطلوبة)
 void performAction(String label) {

 switch (label) {
      case 'save':
      var like= SavedProductsController.instance.isSaved(p.id);
     if (like) {
          SavedProductsController.instance.removeProduct(p.id);
        
        } else {
          SavedProductsController.instance.saveProduct(p);
        }
      case 'like':
     isLike=!isLike;
      case 'close':
      removeFloatingButtons();
     
      default:
      removeFloatingButtons();
        return ;// القيمة الافتراضية إذا لم يكن المدخل صحيحاً
    }


   // Get.snackbar("إجراء", "تم تنفيذ: $label", snackPosition: SnackPosition.BOTTOM);
  }

  /// إزالة التراكب وتنظيف المتغيرات
  void removeFloatingButtons() {
    overlayEntry?.remove();
    overlayEntry = null;
    currentDragPosition.value = null;
  }
}
