class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = false.obs;
  var lastDocument;
  final int pageSize = 10; // عدد المنتجات لكل تحميل

  void fetchProducts() async {
    if (isLoading.value) return;

    isLoading(true);

    try {
      Query query = FirebaseFirestore.instance.collection('products')
          .orderBy('name')
          .limit(pageSize);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }

      QuerySnapshot querySnapshot = await query.get();

      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        var newProducts = querySnapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
        products.addAll(newProducts);
      }
    } catch (e) {
      print('خطأ في جلب المنتجات: $e');
    } finally {
      isLoading(false);
    }
  }
}

 await showSimpleLoadingDialog<String>(
                      context: context,
                      future: () async {
                     //code here
                        return "done2";
                      },
                      // Custom dialog
                      dialogBuilder: (context, _) {
                        return AlertDialog(
                          content: 
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20),
                                TLoaderWidget(),
                           
                                SizedBox(height: 20),
                              ],
                            ),
                          
                        );
                      },
                    );
CarouselSlider.builder(
  itemCount: imageList.length, // عدد الصور في القائمة
  itemBuilder: (context, index, realIndex) {
    return Image.network(imageList[index]); // عرض الصورة
  },
  options: CarouselOptions(
    enableInfiniteScroll: imageList.length > 1, // تعطيل التكرار إذا كان عدد الصور = 1
    scrollPhysics: imageList.length > 1 ? BouncingScrollPhysics() : NeverScrollableScrollPhysics(), // منع الحركة عند صورة واحدة
    autoPlay: imageList.length > 1, // تشغيل تلقائي فقط عند توفر أكثر من صورة
  ),
)


////////////////
///
///
///import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageController extends GetxController {
  RxList<String> imageUrls = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchImages();
  }

  void fetchImages() async {
    var querySnapshot = await FirebaseFirestore.instance.collection('images').get();
    imageUrls.assignAll(querySnapshot.docs.map((doc) => doc['url'].toString()).toList());
  }
}

class CarouselScreen extends StatelessWidget {
  final ImageController controller = Get.put(ImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Carousel Slider with Firebase')),
      body: Center(
        child: Obx(() {
          // تحضير القائمة مع عنصر الإضافة
          final List<Widget> items = controller.imageUrls.map((url) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
              ),
            );
          }).toList();

          // إضافة العنصر الثابت في النهاية
          items.add(GestureDetector(
            onTap: () {
              // إجراء إضافة صورة جديدة هنا
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Center(
                child: Icon(Icons.add, size: 50, color: Colors.blue),
              ),
            ),
          ));

          return CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: false,
            ),
            items: items,
          );
        }),
      ),
    );
  }
}


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body:
        
         Center(
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.storefront, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Start Your Business Now",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "قم بإضافة منتجاتك وابدأ البيع الآن!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // يمكن ربطه بصفحة إضافة منتج
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("إضافة منتج"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: 
        
        Center(
          child:
          
           Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.deepPurpleAccent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_bag, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "COMING SOON",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "ترقبوا افتتاح متجرنا قريبًا!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 15),
                CircularProgressIndicator(
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

////////////


                 Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: TRoundedContainer(
                        width: 364,
                        height: 214,
                        borderColor: TColors.grey,
                        radius: BorderRadius.circular(22),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () =>
                                  controller.addBanner('gallery', vendorId),
                              icon: TRoundedContainer(
                                enableShadow: true,
                                width: 50,
                                height: 50,
                                radius: BorderRadius.circular(300),
                                child: Icon(
                                  CupertinoIcons.add,
                                  color: TColors.primary,
                                ),
                              )),
                          Text(isLocaleEn(context) ? 'Add Banner' : "اضافة بنر")
                        ],
                      ),
                    ),
                  ],
                )
                //////////////////////

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Carousel Slider')),
        body: Center(
          child:
           CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              autoPlay: false,
            ),
            items: List.generate(3, (index) {
              return Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[300], // لون اللوحة الفارغة
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Center(
                  child: Text(
                    'لوحة ${index + 1}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}


 await showSimpleLoadingDialog<String>(
                      context: context,
                      future: () async {
                     //code here
                       

   if (widget.field == 'username' &&
                      ref.read(userNameErrorProvider.notifier).state !=
                          'Username is available') {
                    showDialogError('Choose a unique username', context);
                  } else {
                    if (widget.field == 'username') {
                      _controller.text = _controller.text.toLowerCase().trim();
                    }
                    final userMap = ref.read(userMapProvider.notifier).state!;
                    final updates = {
                      if (_controller.text != userMap[widget.field])
                        widget.field: _controller.text,
                    };
                    for (var entry in updates.entries) {
                      ref.read(userMapProvider.notifier).update(
                          (state) => {...state!, entry.key: entry.value});
                      await updateUserField(entry.key, entry.value);
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated')),
                    );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const StaticBottomNavigator()));
                  }
                   return "done2";
                      },
                      // Custom dialog
                      dialogBuilder: (context, _) {
                        return AlertDialog(
                          content: 
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20),
                                TLoaderWidget(),
                           
                                SizedBox(height: 20),
                              ],
                            ),
                          
                        );
                      },
                    );



// FutureBuilder<List<ProductModel>>(
//               future:controller.fetchProductPageinations(
//                                         vendorId, 'newArrival', 9) ,
//               child: Obx(() => MasonryGridView.count(
//                     crossAxisCount: 2,
//                     mainAxisSpacing: 8,
//                     crossAxisSpacing: 8,
//                     itemCount: controller.newArrivalDynamic.length + 1,
//                     itemBuilder: (context, index) {
//                       if (index == controller.newArrivalDynamic.length) {
//                         return controller.isLoading.value
//                             ? Center(child: CircularProgressIndicator())
//                             : ElevatedButton(
//                                 onPressed: () =>
//                                     controller.fetchProductPageinations(
//                                         vendorId, 'newArrival', 9),
//                                 child: Text("عرض المزيد"),
//                               );
//                       }
//                       return ProductWidgetMedium(
//                         product: controller.newArrivalDynamic[index],
//                         vendorId: vendorId,
//                       );
//                     },
//                   )),
//             )

Obx(() => MasonryGridView.count(
  crossAxisCount: 2,
  mainAxisSpacing: 8,
  crossAxisSpacing: 8,
  itemCount: controller.products.length + 1,
  itemBuilder: (context, index) {
    if (index == controller.products.length) {
      return controller.isLoading.value
          ? Center(child: CircularProgressIndicator())
          : ElevatedButton(
              onPressed: controller.fetchProducts,
              child: Text("عرض المزيد"),
            );
    }
    return ProductCard(product: controller.products[index]);
  },
))

  return Obx(
              () => Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TCustomWidgets.buildTitle(
                      isArabicLocale() ? 'وصلنا حديثا' : 'New Arrival'),
                  const SizedBox(
                    height: TSizes.spaceBtWItems,
                  ),
                  Stack(
                    children: [
                      (newArriveal.length > 9)
                          ? MasonryGridView.count(
                              itemCount: newArriveal.sublist(0, 9).length,
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(
                                              milliseconds: 1000),
                                          pageBuilder:
                                              (context, anim1, anim2) =>
                                                  ProductDetails(
                                            product: newArriveal.sublist(
                                                0, 9)[index],
                                            vendorId: vendorId,
                                          ),
                                        ));
                                  },
                                  child: TRoundedContainer(
                                    width: 100.w / 3,
                                    height: 227,
                                    // showBorder: true,
                                    child: CustomCaChedNetworkImage(
                                        width: 100.w / 3,
                                        height: 227,
                                        raduis: BorderRadius.circular(0),
                                        url: newArriveal
                                            .sublist(0, 9)[index]
                                            .images!
                                            .first),
                                  ),
                                );
                              },
                            )
                          : MasonryGridView.count(
                              itemCount: newArriveal.length,
                              crossAxisCount: 3,
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              padding: const EdgeInsets.all(0),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration: const Duration(
                                              milliseconds: 1000),
                                          pageBuilder:
                                              (context, anim1, anim2) =>
                                                  ProductDetails(
                                            product: newArriveal[index],
                                            vendorId: vendorId,
                                          ),
                                        ));
                                  },
                                  child: TRoundedContainer(
                                    width: 100.w / 3,
                                    height: 200,
                                    // showBorder: true,
                                    child: CustomCaChedNetworkImage(
                                        width: 100.w / 3,
                                        height: 200,
                                        raduis: BorderRadius.circular(0),
                                        url: newArriveal[index].images!.first),
                                  ),
                                );
                              },
                            ),
                      Visibility(
                        visible: editMode,
                        child: Positioned(
                            bottom: 0,
                            right: isArabicLocale() ? null : 0,
                            left: isArabicLocale() ? 0 : null,
                            child: CustomFloatActionButton(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateProduct(
                                            vendorId: vendorId,
                                            type: 'newArrival',
                                            sectionId: 'all',
                                          ))),
                            )),
                      )
                    ],
                  )
                ],
              ),
            );
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'category_controller.dart';
import 'add_category_screen.dart'; // تأكد من إنشاء هذه الصفحة

class AddProductScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Obx(() {
              // إنشاء القائمة مع خيار "إضافة فئة"
              List<String> dropdownItems = [...categoryController.categories, "إضافة فئة"];
              
              return DropdownButtonFormField<String>(
                value: categoryController.selectedCategory.value,
                items: dropdownItems.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == "إضافة فئة") {
                    Get.to(AddCategoryScreen()); // فتح صفحة إضافة الفئة
                  } else {
                    categoryController.setSelectedCategory(value!);
                  }
                },
                decoration: InputDecoration(
                  labelText: "Select Category",
                  border: OutlineInputBorder(),
                ),
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String selectedCategory = categoryController.selectedCategory.value;
                print("Product will be assigned to category: $selectedCategory");
                // يمكنك إرسال الفئة مع بيانات المنتج إلى Firebase هنا
              },
              child: Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }



  class SavedProductsController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var savedProducts = <Product>[].obs;
  final String userId = "user123"; // Example User ID

  @override
  void onInit() {
    super.onInit();
    fetchSavedProducts();
  }

  // Fetch saved products list from Firebase
  void fetchSavedProducts() async {
    var snapshot = await _firestore.collection('saved_products')
        .where('userId', isEqualTo: userId)
        .get();

    savedProducts.value = snapshot.docs.map((doc) => 
      Product.fromJson(doc.data())).toList();
  }

  // Save product only if it's not already in the fetched list
  void saveProduct(Product product) async {
    if (savedProducts.any((p) => p.id == product.id)) {
      print("Product already saved.");
      return;
    }

    savedProducts.add(product); // Update local list

    // Push the entire updated list to Firebase
    List<Map<String, dynamic>> updatedList = savedProducts.map((p) => p.toJson()).toList();

    await _firestore.collection('saved_products').doc(userId).set({
      'userId': userId,
      'products': updatedList,
    });

    fetchSavedProducts(); // Refresh list after update
  }
}
}