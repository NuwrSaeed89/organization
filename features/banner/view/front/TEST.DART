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



////////////
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FileController extends GetxController {
  var filePath = ''.obs;

  Future<void> downloadExcelFile() async {
    try {
      // ✅ 1. قراءة ملف Excel من `assets`
      ByteData data = await rootBundle.load('assets/template.xlsx');
      List<int> bytes = data.buffer.asUint8List();

      // ✅ 2. حفظ الملف محليًا في مجلد المستندات
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/template.xlsx');
      await file.writeAsBytes(bytes);

      // ✅ 3. تحديث المسار حتى يمكن عرضه للمستخدم
      filePath.value = file.path;

      Get.snackbar("نجاح", "تم تحميل نموذج Excel بنجاح!");
    } catch (e) {
      Get.snackbar("خطأ", "حدث خطأ أثناء تحميل الملف!");
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      filePath.value = result.files.single.path!;
      Get.snackbar("نجاح", "تم تحديد الملف: ${result.files.single.name}");
    } else {
      Get.snackbar("إلغاء", "لم يتم اختيار ملف.");
    }
  }
}




  ///////////////category list on tow rows
  ///

            Visibility(
    visible: false,
              child: Obx(
                () {
                  if (CategoryController.instance.load.value) {
                    return Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          height: 180,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // عرض عنصرين لكل سطر
                              childAspectRatio: 1, // نسبة العرض إلى الارتفاع
                              crossAxisSpacing: 10, // تباعد بين العناصر عموديًا
                              mainAxisSpacing: 10, // تباعد بين العناصر أفقيًا
                            ),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: TRoundedContainer(
                                      showBorder: true,
                                      enableShadow: true,
                                      //   borderColor: TColors.darkerGray,
                                      // enableShadow: true,
                                      // decoration: BoxDecoration(
                                      //     border: Border.all(
              
                                      //         color: TColors.darkerGray,
                                      //         width: 1,
                                      //         strokeAlign: BorderSide
                                      //             .strokeAlignOutside),
                                      //     color: Colors.grey,
                                      radius: BorderRadius.circular(100),
                                      child: TShimmerEffect(
                                        width: 70,
                                        height: 70,
                                        raduis: BorderRadius.circular(300),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  } else {
                    if (CategoryController.instance.allItems.isEmpty) {
                      return editMode
                          ? Column(
                              children: [
                                Container(
                                  color: Colors.transparent,
                                  height: 200,
                                  child: GridView.builder(
                                    scrollDirection: Axis.horizontal,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, // عرض عنصرين لكل سطر
                                      childAspectRatio:
                                          1, // نسبة العرض إلى الارتفاع
                                      crossAxisSpacing:
                                          2, // تباعد بين العناصر عموديًا
                                      mainAxisSpacing:
                                          10, // تباعد بين العناصر أفقيًا
                                    ),
                                    itemCount: 7,
                                    itemBuilder: (context, index) {
                                      if (index == 0) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: addCategoryItem(index, context),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TRoundedContainer(
                                            backgroundColor: Colors.white,
                                            showBorder: true,
                                            enableShadow: true,
                                            radius: BorderRadius.circular(300),
                                            width: 70,
                                            height: 70,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                )
                              ],
                            )
                          : const SizedBox.shrink();
                    } else {
                      return editMode
                          ? Stack(
                              children: [
                                Center(
                                  child: TRoundedContainer(
                                    backgroundColor: Colors.transparent,
                                    height: 270,
                                    width: 100 *
                                        (CategoryController
                                                .instance.allItems.length +
                                            1 % 2 +
                                            CategoryController
                                                .instance.allItems.length +
                                            1 / 2),
                                    showBorder: false,
              
                                    //borderColor: Colors.red,
                                    child: GridView.builder(
                                      scrollDirection: Axis.horizontal,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2, // عرض عنصرين لكل سطر
                                        childAspectRatio:
                                            1, // نسبة العرض إلى الارتفاع
                                        crossAxisSpacing:
                                            2, // تباعد بين العناصر عموديًا
                                        mainAxisSpacing:
                                            10, // تباعد بين العناصر أفقيًا
                                      ),
                                      itemCount: CategoryController
                                              .instance.allItems.length +
                                          1,
                                      itemBuilder: (context, index) {
                                        // if (index == categories.length + 2) {
                                        //   // العنصر الثابت في النهاية
                                        //   return Padding(
                                        //       padding: const EdgeInsets.only(
                                        //           bottom: 41.0),
                                        //       child:
                                        //           addCategoryItem(index, context));
                                        // }
              
                                        if (index ==
                                            CategoryController
                                                .instance.allItems.length) {
                                          // العنصر الثابت في النهاية
                                          return Center(
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10,
                                                            right: 10,
                                                            bottom: 45.0),
                                                    child: addCategoryItem(
                                                        index, context)),
                                                const SizedBox(
                                                  width: 10,
                                                )
                                              ],
                                            ),
                                          );
                                        }
              
                                        return Row(
                                          children: [
                                            if (index == 0)
                                              const SizedBox(
                                                width: 5,
                                              ),
                                            TCategoryGridItem(
                                                category: CategoryController
                                                    .instance.allItems[index],
                                                editMode: editMode,
                                                vendorId: vendorId),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Center(
                              child: Container(
                                color: Colors.transparent,
                                height: 240,
                                width: 100 *
                                    (CategoryController.instance.allItems.length %
                                            2 +
                                        CategoryController
                                                .instance.allItems.length /
                                            2),
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, // عرض عنصرين لكل سطر
                                    childAspectRatio:
                                        1.1, // نسبة العرض إلى الارتفاع
                                    crossAxisSpacing:
                                        2, // تباعد بين العناصر عموديًا
                                    mainAxisSpacing:
                                        10, // تباعد بين العناصر أفقيًا
                                  ),
                                  itemCount:
                                      CategoryController.instance.allItems.length,
                                  itemBuilder: (context, index) {
                                    return TCategoryGridItem(
                                        category: CategoryController
                                            .instance.allItems[index],
                                        editMode: editMode,
                                        vendorId: vendorId);
                                  },
                                ),
                              ),
                            );
                    }
                  }
                },
              ),
            ),


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('قائمة المنتجات')),
      body: Column(
        children: [
          // قائمة الفئات الأفقية
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                return GestureDetector(
                  onTap: () => controller.selectCategory(category),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(category.name, style: TextStyle(color: Colors.white)),
                  ),
                );
              }).toList(),
            ),
          ),

          // قائمة المنتجات العمودية الممتدة مع Animation
          
        ],
      ),
    );
  }
class ProductController extends GetxController {
  var selectedCategory = Rx<CategoryModel?>(null);
  var isExpanded = false.obs;
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // جلب المنتجات الخاصة بالفئة من Firestore
  Future<void> fetchProducts(String categoryId) async {
    isLoading.value = true;

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('products')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      List<ProductModel> fetchedProducts = querySnapshot.docs
          .map((doc) => ProductModel.fromDocument(doc))
          .toList();

      products.assignAll(fetchedProducts);
    } catch (e) {
      print('Error fetching products: $e');
    }

    isLoading.value = false;
  }

  void selectCategory(CategoryModel category) async {
    if (selectedCategory.value == category && isExpanded.value) {
      isExpanded.value = false;
    } else {
      selectedCategory.value = category;
      await fetchProducts(category.id);
      isExpanded.value = true;
    }
  }

  void closeList() {
    isExpanded.value = false;
  }
}





class ProductScreen extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('قائمة المنتجات')),
      body: Column(
        children: [
          // جلب قائمة الفئات من Firestore
          FutureBuilder<QuerySnapshot>(
            future: firestore.collection('categories').get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('حدث خطأ في جلب الفئات'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('لا توجد فئات متاحة'));
              }

              List<CategoryModel> categories = snapshot.data!.docs
                  .map((doc) => CategoryModel.fromDocument(doc))
                  .toList();

              return SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: categories.map((category) {
                    return GestureDetector(
                      onTap: () => controller.selectCategory(category),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(category.name, style: TextStyle(color: Colors.white)),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),

          // قائمة المنتجات العمودية مع حالة التحميل
          Obx(() {
            return 
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: controller.isExpanded.value ? 300 : 0,
              child: controller.isExpanded.value
                  ? Column(
                      children: [
                        Expanded(
                          child: Obx(() {
                            if (controller.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else if (controller.products.isEmpty) {
                              return Center(child: Text('لا توجد منتجات لهذه الفئة'));
                            }
                            return ListView.builder(
                              itemCount: controller.products.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(controller.products[index].name),
                                  tileColor: Colors.grey.shade200,
                                );
                              },
                            );
                          }),
                        ),

                        // زر الإغلاق
                        ElevatedButton(
                          onPressed: controller.closeList,
                          child: Text('إغلاق القائمة'),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            );
          }),
        ],
      ),
    );
  }
}
   MasonryGridView.count(
                                      itemCount: spotList.length,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                      padding: const EdgeInsets.all(0),
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return 
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 1000),
                                                  pageBuilder:
                                                      (context, anim1, anim2) =>
                                                          ProductDetails(
                                                    product: spotList[index],
                                                    vendorId: vendorId,
                                                  ),
                                                ));
                                          },
                                          child: ProductWidgetMedium(
                                            prefferWidth: 174,
                                            prefferHeight: 226,
                                            product: spotList[index],
                                            vendorId: vendorId,
                                            editMode: editMode,
                                          ),
                                        );
                                      },
                                    )