import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:winto/features/organization/e_commerce/features/sector/model/sector_model.dart';


class SectorController extends GetxController {
  var sectors = <SectorModel>[].obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void fetchSectors(String vendorId) async {
    var snapshot = await firestore.collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1').collection('sectors').get();
         
    sectors.value = snapshot.docs.map((doc) => SectorModel.fromMap(doc.data())).toList();
  }



  Future<void> updateSectorName(String sectorId, String arabicName, String englishName, String vendorId) async {
    await firestore.collection('users')
          .doc(vendorId)
          .collection('organization')
          .doc('1').collection('sectors').doc(sectorId).update({
      'arabicName': arabicName,
      'englishName': englishName,
    });

    var sectorIndex = sectors.indexWhere((s) => s.id == sectorId);
    if (sectorIndex != -1) {
      sectors[sectorIndex].arabicName = arabicName;
      sectors[sectorIndex].englishName = englishName;
      update();
    }
  }

  String getSectorName(String sectorId, String lang) {
    var sector = sectors.firstWhere((s) => s.id == sectorId, orElse: () => SectorModel(id: sectorId,name: 'name' ,arabicName: "اسم افتراضي", englishName: "Default Name"));
    return lang == "ar" ? sector.arabicName : sector.englishName;
  }
}
