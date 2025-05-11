import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:winto/features/organization/e_commerce/features/product/data/product_model.dart';

class ExcelController extends GetxController {
  var filePath = ''.obs;
  var excelData = <List<dynamic>>[].obs;

String vendorId=FirebaseAuth.instance.currentUser!.uid;
 void onInit() {
   
    fetchtempProduct();
     super.onInit();
  }

  // Fetch saved products list from Firebase
  void fetchtempProduct() async {
    var snapshot = await FirebaseFirestore.instance.collection('users')
          .doc(vendorId).collection('temp_products_$vendorId')
        .get();
    products.value =
        snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
  }

  Future<void> downloadExcelFile() async {
    try {


       var status = await Permission.storage.request();
  if (status.isGranted) {
    print("تم منح الإذن للوصول إلى الملفات!");
  } else {
    print("الإذن مرفوض، يرجى تفعيله يدويًا.");
  }
      // ✅ 1. قراءة ملف Excel من `assets`
      ByteData data = await rootBundle.load('assets/template.xlsx');
      List<int> bytes = data.buffer.asUint8List();
//assets\template.xlsx
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

final RxList<ProductModel> products = <ProductModel>[].obs;
  void pickFile(String vendorId) async {
    if (kDebugMode) {
      print("===================vendorid$vendorId");
    }
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
      var salePrice = row[5]?.value.toString();
      var item=ProductModel(id: '', title: title!, arabicTitle: arabicTitle!,
        price: double.parse(price.toString()),
        salePrice: double.parse(salePrice.toString()),
        
        description: description!, arabicDescription: arabicDescription!, vendorId: vendorId);
       products.add(item);
      
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


void storeTempProducts  ( String vendorId) async{
  var updatedList = products.map((p) => p.toJson()).toList();

   await FirebaseFirestore.instance.collection('users')
          .doc(vendorId).set({
     
      'temp_products_$vendorId': updatedList,
    });
  var collectionRef = FirebaseFirestore.instance.collection('users')
          .doc(vendorId).collection('temp_products_$vendorId');

 
  
  
}



}
