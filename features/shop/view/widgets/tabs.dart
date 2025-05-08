// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class FloatingButtonController extends GetxController {
//   OverlayEntry? overlayEntry;

//   void showFloatingButton(BuildContext context, Offset position) {
//     removeFloatingButton(); // إزالة أي زر سابق قبل إظهار الجديد

//     overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         left: position.dx - 30,
//         top: position.dy - 50,
//         child: Column(
//           children: [
//             _buildFloatingButton(Icons.favorite, "حفظ"),
//             SizedBox(height: 10),
//             _buildFloatingButton(Icons.share, "مشاركة"),
//           ],
//         ),
//       ),
//     );

//     Overlay.of(context).insert(overlayEntry!);
//   }

//   Widget _buildFloatingButton(IconData icon, String label) {
//     return FloatingActionButton.extended(
//       onPressed: () => removeFloatingButton(),
//       icon: Icon(icon, color: Colors.white),
//       label: Text(label, style: TextStyle(color: Colors.white)),
//       backgroundColor: Colors.black,
//     );
//   }

//   void removeFloatingButton() {
//     overlayEntry?.remove();
//     overlayEntry = null;
//   }
// }

// class PinterestStyleScreen extends StatelessWidget {
//   final FloatingButtonController controller =
//       Get.put(FloatingButtonController());
//   final GlobalKey _key = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: GestureDetector(
//           key: _key,
//           onLongPress: () {
//             final RenderBox renderBox =
//                 _key.currentContext!.findRenderObject() as RenderBox;
//             final Offset position = renderBox.localToGlobal(Offset.zero);
//             controller.showFloatingButton(context, position);
//           },
//           child: Card(
//             elevation: 5,
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Text("اضغط مطولًا لإظهار الزر العائم مثل Pinterest"),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:math';

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

class ProductListScreen extends StatelessWidget {
  final FloatingButtonsController controller =
      Get.put(FloatingButtonsController());

  @override
  Widget build(BuildContext context) {
    List<String> products = ["منتج 1", "منتج 2", "منتج 3", "منتج 4", "منتج 5"];

    return Scaffold(
      appBar: AppBar(title: Text("قائمة المنتجات")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          GlobalKey itemKey = GlobalKey(); // مفتاح لكل عنصر

          return GestureDetector(
            key: itemKey,
            onLongPress: () {
              controller.showFloatingButtons(context, itemKey);
            },
            child: Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ListTile(
                title: Text(products[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
