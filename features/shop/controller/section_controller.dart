import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:winto/features/organization/e_commerce/features/shop/data/section_model.dart';
// استورد النموذج الذي أنشأته

class SectionsController extends GetxController {
  RxList<SectionModel> sections = <SectionModel>[].obs;
  RxBool loadingSection = false.obs;
  late String vendorId;
  SectionsController(this.vendorId);
  @override
  void onInit() {
    super.onInit();
    fetchSections(); // جلب البيانات عند البدء
  }

  void fetchSections() async {
    loadingSection.value = true;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(vendorId)
        .collection('organization')
        .doc('1')
        .collection('sections')
        .get();
    sections.value = snapshot.docs
        .map((doc) => SectionModel.fromMap(doc.data(), doc.id))
        .toList();
    loadingSection.value = false;
  }

  void addSection(SectionModel section, String vendorId) async {
    final newDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(vendorId)
        .collection('organization')
        .doc('1')
        .collection('sections')
        .add({'name': section.name, 'arabicName': section.arabicName});

    fetchSections(); // تحديث الأقسام بعد الإضافة
  }
}
