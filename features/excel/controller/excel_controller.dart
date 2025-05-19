import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';

import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';

class ExcelController extends GetxController {
  var filePath = ''.obs;
  var excelData = <List<dynamic>>[].obs;
final RxList<ProductModel> products = <ProductModel>[].obs;
  void pickFile(String vendorId) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      filePath.value = result.files.single.path!;
      _readExcel(File(filePath.value),vendorId);
    }
  }

  void _readExcel(File file,String vendorId) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel.tables[excel.tables.keys.first];

    if (sheet != null) {
      for (var row in sheet.rows) {
        excelData.add(row.map((cell) => cell?.value ?? "").toList());
      
      var title = row[0]?.value.toString();
       var description = row[1]?.value.toString();
        var arabicTitle = row[2]?.value.toString();
         var arabicDescription = row[3]?.value.toString();
      var price = row[4]?.value.toString();
      var oldPrice = row[5]?.value.toString();
       products.add(ProductModel(id: '', title: title!, arabicTitle: arabicTitle!,
        price: double.parse(price.toString()),
        oldPrice: double.parse(oldPrice.toString()),
        
        description: description!, arabicDescription: arabicDescription!, vendorId: vendorId));
      }
      storeTempProducts(vendorId);
    }
  }


void readExcel(File file) {
  var bytes = file.readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      print(row.map((cell) => cell?.value.toString()).toList());
    }
  }
}


void storeTempProducts( String userId) {
  var collectionRef = FirebaseFirestore.instance.collection('temp_products_$userId');

 
    collectionRef.add(excelData as Map<String, dynamic>);
  
}

  void refreshData() {
    fetchTemporaryData();
  }

  void fetchTemporaryData() async {
    var snapshot = await FirebaseFirestore.instance.collection('temporary_data').get();
    products.value = snapshot.docs
       .map((doc) => ProductModel.fromSnapshot(doc))
        .toList();
  }

  void updateItem(int index, String field, String value) {
    var product = products[index];
    if (field == "name") product.title = value;
    if (field == "price") product.price = double.parse(value);
    if (field == "description") product.description = value;
    products.refresh();
  }

  Future<void> saveChanges() async {
    for (var product in products) {
      await FirebaseFirestore.instance.collection('temporary_data').doc(product.id).update(product.toJson());
    }
  }

}
