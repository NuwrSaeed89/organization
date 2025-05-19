// لإنشاء تطبيق باستخدام فلاتر لسحب الفئات من قاعدة بيانات Firestore وعرضها بشكل قائمة منسدلة، يمكنك استخدام الكود التالي كمثال. سأقوم بتوضيح كيفية استخدام FutureBuilder لجلب البيانات من Firestore وعرض الفئات والفئات الفرعية.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:winto/app/app_localization.dart';
import 'package:winto/features/organization/e_commerce/data/models/category_model.dart';
import 'package:winto/features/organization/e_commerce/data/repositories/category_repository.dart';
import 'package:winto/features/organization/e_commerce/features/category/view/all_category/widgets/category_list_item.dart';
import 'package:winto/features/organization/e_commerce/features/shop/view/widgets/control_panel_menu.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/loader/circle_loader.dart';

class CategoryListTile extends StatelessWidget {
  var userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    return Scaffold(
      appBar: const CustomAppBar(title: "الفئات"),
      body: SafeArea(
        child: Column(
          children: [
            ControlPanelMenu(
              vendorId: userId,
            ),
            Flexible(
              child: FutureBuilder(
                future: CategoryRepository.instance.getAllCategories(),
                // FirebaseFirestore.instance
                //     .collection('users')
                //     .doc(userId)
                //     .collection('organization')
                //     .doc('1')
                //     .collection("category")
                //     .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: TLoaderWidget());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: Text("حدث خطأ"));
                  }
        
                  final categories = snapshot.data!;
        
                  return ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
        
                      return ExpansionTile(
                        title: TCategoryListItem(
                          category: category,
                        ), //Text(category['Name']),
                        children: [
                          FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('users')
                                .doc(userId)
                                .collection('organization')
                                .doc('1')
                                .collection("category")
                                .doc(category.id)
                                .collection('subcategories')
                                .get(),
                            builder: (context, subSnapshot) {
                              if (subSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(child: TLoaderWidget());
                              }
                              if (subSnapshot.hasError) {
                                return const Center(child: Text("opps"));
                              }
        
                              final subcategories = subSnapshot.data!.docs;
        
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: subcategories.length,
                                itemBuilder: (context, subIndex) {
                                  final subcategory = subcategories[subIndex];
                                  var subModel = CategoryModel(
                                    arabicName: subcategory['ArabicName'],
                                    id: subcategory.id,
                                    name: subcategory['name'],
                                  );
                                  return ExpansionTile(
                                    title: TCategoryListItem(
                                      category: subModel,
                                    ),
                                    children: [
                                      FutureBuilder<QuerySnapshot>(
                                        future: FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(userId)
                                            .collection('organization')
                                            .doc('1')
                                            .collection("category")
                                            .doc(category.id)
                                            .collection('subcategories')
                                            .doc(subcategory.id)
                                            .collection('subcategories')
                                            .get(),
                                        builder: (context, subSnapshot) {
                                          if (subSnapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child: const TLoaderWidget());
                                          }
                                          if (subSnapshot.hasError) {
                                            return const Center(
                                                child: Text("opps"));
                                          }
        
                                          final subsubcategories =
                                              subSnapshot.data!.docs;
        
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: subsubcategories.length,
                                            itemBuilder: (context, subIndex) {
                                              final subsubcategory =
                                                  subsubcategories[subIndex];
                                              return ExpansionTile(
                                                  title: Text(
                                                      "     ${subcategory['name']}"),
                                                  children: [
                                                    FutureBuilder<QuerySnapshot>(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(userId)
                                                          .collection(
                                                              'organization')
                                                          .doc('1')
                                                          .collection("category")
                                                          .doc(category.id)
                                                          .collection(
                                                              'subcategories')
                                                          .doc(subcategory.id)
                                                          .collection(
                                                              'subcategories')
                                                          .doc(subsubcategory.id)
                                                          .collection(
                                                              'subcategories')
                                                          .get(),
                                                      builder:
                                                          (context, subSnapshot) {
                                                        if (subSnapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                              child:
                                                                  TLoaderWidget());
                                                        }
                                                        if (subSnapshot
                                                            .hasError) {
                                                          return const Center(
                                                              child:
                                                                  Text("opps"));
                                                        }
        
                                                        final sub3categories =
                                                            subSnapshot
                                                                .data!.docs;
        
                                                        return ListView.builder(
                                                          shrinkWrap: true,
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          itemCount:
                                                              sub3categories
                                                                  .length,
                                                          itemBuilder: (context,
                                                              subIndex) {
                                                            final sub3category =
                                                                sub3categories[
                                                                    subIndex];
                                                            return ExpansionTile(
                                                              title: Text(
                                                                  "           ${sub3category['Name']}"),
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ]);
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
