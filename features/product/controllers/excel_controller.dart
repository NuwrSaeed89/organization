import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:excel/excel.dart';
import 'dart:io';

class ExcelController extends GetxController {
  var filePath = ''.obs;
  var excelData = <List<dynamic>>[].obs;

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null) {
      filePath.value = result.files.single.path!;
      _readExcel(File(filePath.value));
    }
  }

  void _readExcel(File file) async {
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel.tables[excel.tables.keys.first];

    if (sheet != null) {
      for (var row in sheet.rows) {
        excelData.add(row.map((cell) => cell?.value ?? "").toList());
      }
    }
  }
}
