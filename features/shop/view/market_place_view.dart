import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/controllers/category_controller.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/profile_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/section_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/controller/tab_controller.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/section_model.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/all_tab.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/hello_client.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/hello_vendor.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/market_header_organization.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class MarketPlaceView extends StatelessWidget {
  const MarketPlaceView(
      {super.key, required this.editMode, required this.vendorId});
  final bool editMode;
  final String vendorId;
  @override
  Widget build(BuildContext context) {
ProfileController.instance.fetchVendorData(vendorId);
return Scaffold(body: SafeArea(
  child:
  
  
   FutureBuilder(
        future:  CategoryController.instance
   .getCategoryOfUser(vendorId), // جلب البيانات قبل عرض الصفحة
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: TLoaderWidget()); // عرض مؤشر تحميل
          } else {
            return _buildBody();
          }
        },
      ),
  
  
));



   
  }
  
  _buildBody() {
    return 
     NestedScrollViewForHome(
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
    var userId = FirebaseAuth.instance.currentUser!.uid;
    // final profileController = ProfileController.instance;
    // var user = ProfileController.instance.fetchVendorData(vendorId);
    var categoryController=CategoryController.instance;
   //categoryController.getCategoryOfUser(vendorId);
    //RxList<CategoryModel> categories  = categoryController.allItems;

   // final TabControllerX tabControllerX = Get.put(TabControllerX(vendorId));
    final SectionsController secControllerX =
        Get.put(SectionsController(vendorId));
 
    secControllerX.fetchSections();
   
      // 
       if  (categoryController.allItems.isEmpty){
if(vendorId ==userId) {
  return  HellowVendor(vendorId: vendorId, editMode: true);
} else {
  return HelloClient(vendorId: vendorId, editMode: editMode);
}


       }
           else {
         return    SingleChildScrollView(
         child: Column(children: [
            
               marketHeaderSection(
                   vendorId,
                   editMode,
                   vendorId ==
                       FirebaseAuth.instance.currentUser!.uid),
               // SliverPersistentHeader(
               //   delegate: _SliverAppBarDelegate(
               //     TabBar(
               //         isScrollable: true,
                   
               //         // indicatorColor: TColors.red,
               //         indicatorSize: TabBarIndicatorSize.tab,
               //         indicatorPadding: const EdgeInsets.symmetric(
               //             vertical: 5, horizontal: 0),
               //         controller: tabControllerX.tabController,
               //         indicator: BoxDecoration(
               //           color: Colors.black,
               //           borderRadius: BorderRadius.circular(40),
               //         ),
               //         labelColor: Colors.white,
               //         unselectedLabelColor: TColors.darkerGray,
               //         tabs: [
               //           // Tab(
               //           //     text: isLocaleEn(context)
               //           //         ? 'All'
               //           //         : 'الكل'),
               //           // ...secControllerX.sections
               //           //     .map((section) => Tab(text: section.name)),
               //           // if (editMode)
               //           //   Tab(
               //           //     icon: IconButton(
               //           //       onPressed: () => addSection(
               //           //           context, secControllerX, vendorId),
               //           //       icon: Icon(CupertinoIcons.add_circled),
               //           //     ),
               //           //   )
               //         ]
               //         //   onTap: (index) {
               //         //     // إذا كانت الأقسام فارغة أو الضغط على تاب "الإضافة"
                   
               //         //     // عرض نموذج الإضافة
                   
               //         //   },
               //         ),
               //   ),
               // ),
           
               Padding(
                 padding: const EdgeInsets.only(top:28.0),
                 child: AllTab(
                   vendorId: vendorId,
                   editMode: editMode,
                 ),
               )
               ]));
       }
              
             
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
