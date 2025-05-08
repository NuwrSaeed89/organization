import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'dart:async';

class FloatingButtonsController extends GetxController {
  OverlayEntry? overlayEntry;

  void showFloatingButtons(BuildContext context, GlobalKey key) {
    removeFloatingButtons(); // إزالة أي أزرار سابقة

    // الحصول على الموقع الفعلي للعنصر المضغوط
    final RenderBox renderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final Offset position = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: List.generate(4, (index) {
          double angle = (pi / 2) * index; // ترتيب دائري للأزرار
          return Positioned(
            left: position.dx + 50 * cos(angle),
            top: position.dy + 50 * sin(angle),
            child: FloatingActionButton(
              onPressed: () => removeFloatingButtons(),
              child: Icon(_getIcon(index), color: Colors.white),
              backgroundColor: Colors.black,
            ),
          );
        }),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);

    // إخفاء تلقائي بعد 5 ثوانٍ إذا لم يتم الضغط
    Timer(Duration(seconds: 5), () {
      if (overlayEntry != null) removeFloatingButtons();
    });
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.favorite;
      case 1:
        return Icons.share;
      case 2:
        return Icons.shopping_cart;
      case 3:
        return Icons.close;
      default:
        return Icons.help;
    }
  }

  void removeFloatingButtons() {
    overlayEntry?.remove();
    overlayEntry = null;
  }
}
