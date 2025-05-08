import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabControllerX extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabControllerX(this.vendorId);
  late TabController tabController;
  var sections = <Map<String, dynamic>>[].obs;
  late String vendorId;

  @override
  void onInit() {
    super.onInit();
    fetchSections();

    tabController = TabController(length: sections.length + 1, vsync: this);
  }

  void fetchSections() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1')
          .collection('sections')
          .get();
      sections.value = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching sections: $e');
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
