import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/editing._controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/section_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/tab_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/section_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/all_tab.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/market_header.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class MarketPlaceManagment extends StatelessWidget {
  const MarketPlaceManagment(
      {super.key, required this.editMode, required this.vendorId});
  final bool editMode;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
    return NestedScrollViewForHome(
      vendorId: vendorId,
      editMode: editMode,
    );
  }
}

class NestedScrollViewForHome extends StatelessWidget {
  RxInt selectedIndex = 0.obs;
  final bool editMode;
  final String vendorId;
  NestedScrollViewForHome(
      {super.key, required this.editMode, required this.vendorId});

  @override
  Widget build(BuildContext context) {
    // final profileController = ProfileController.instance;
    // var user = ProfileController.instance.fetchVendorData(vendorId);
    CategoryController.instance.getCategoryOfUser(vendorId);
    var categories = CategoryController.instance.allItems;
    // List<ProductModel> featureProduct = [];
    // List<ProductModel> saleProduct = ProductController.instance.saleProduct;
    // featureProduct.assignAll(ProductController.instance.allItems
    //     .where((p0) => p0.isFeature == true));

    final TabControllerX tabControllerX = Get.put(TabControllerX(vendorId));
    final SectionsController secControllerX =
        Get.put(SectionsController(vendorId));
    var editingController = Get.put(EditingController());
    secControllerX.fetchSections();
    return SafeArea(
        child: Scaffold(
            body: DefaultTabController(
      length: 1, //getLength(secControllerX.sections, editMode),
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: marketHeaderSection(vendorId, editMode, true),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                    isScrollable: true,

                    // indicatorColor: TColors.red,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                    controller: tabControllerX.tabController,
                    indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: TColors.darkerGray,
                    tabs: [
                      Tab(text: isLocaleEn(context) ? 'All' : 'الكل'),
                      // ...secControllerX.sections
                      //     .map((section) => Tab(text: section.name)),
                      // if (editMode)
                      //   Tab(
                      //     icon: IconButton(
                      //       onPressed: () => addSection(
                      //           context, secControllerX, vendorId),
                      //       icon: Icon(CupertinoIcons.add_circled),
                      //     ),
                      //   )
                    ]
                    //   onTap: (index) {
                    //     // إذا كانت الأقسام فارغة أو الضغط على تاب "الإضافة"

                    //     // عرض نموذج الإضافة

                    //   },
                    ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabControllerX.tabController,
          children: [
            AllTab(
              vendorId: vendorId,
              editMode: editMode,
            ),
            // ...secControllerX.sections
            //     .map((section) => _buildTabContent(section.name)),
          ],
        ),
      ),
    )));
  }
}

Widget _buildTabContent(String text) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: List.generate(
          20,
          (index) => Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            child: ListTile(
              title: Text('$text - عنصر $index'),
            ),
          ),
        ),
      ),
    ),
  );
}

int getLength(RxList<SectionModel> sections, bool editMode) {
  if (sections.isEmpty) {
    return editMode ? 2 : 1;
  } else {
    return editMode ? sections.length + 2 : sections.length + 1;
  }
}

void addSection(BuildContext context, SectionsController ctr, String vendorId) {
  showDialog(
    context: context,
    builder: (context) {
      SectionModel section = SectionModel.empty();
      return AlertDialog(
        title: Text(isArabicLocale() ? 'أضف قسم جديد' : 'Add New Section'),
        content: Column(
          children: [
            TextField(
              onChanged: (value) {
                section.name = value;
              },
              decoration: const InputDecoration(hintText: 'English Name'),
            ),
            TextField(
              onChanged: (value) {
                section.arabicName = value;
              },
              decoration: const InputDecoration(hintText: 'الاسم العربي'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              ctr.addSection(section, vendorId);
              Navigator.pop(context); // إغلاق النموذج بعد الإضافة
            },
            child: Text(isArabicLocale() ? 'إضافة' : 'Add'),
          ),
        ],
      );
    },
  );
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _SliverAppBarDelegate(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 4),
      color: Colors.white,
      child: tabBar,
    );
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
