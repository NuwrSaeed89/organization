import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/excel_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';


class ImportExcelPage extends StatelessWidget {
 var controller = Get.put(ExcelController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: isArabicLocale()?  '💾 استيراد البيانات من Excel':'Import Data From Excel 💾'),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              '📜 اتبع الخطوات التالية:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('📥 قم بتحميل نموذج الإدخال ثم ارفع الملف لاستيراد البيانات.'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.pickFile();
              },
              child: Text('📤 رفع ملف Excel'),
            ),
            SizedBox(height: 20),
            Obx(() => controller.filePath.value.isNotEmpty
                ? Text('✅ الملف: ${controller.filePath.value}')
                : Text('⚠️ لم يتم اختيار ملف بعد!')),
            SizedBox(height: 20),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.excelData.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.excelData[index].join(' | ')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
