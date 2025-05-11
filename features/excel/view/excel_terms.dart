import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/product/controllers/excel_controller.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/buttons/custom_button.dart';


class ImportExcelPage extends StatelessWidget {
 var controller = Get.put(ExcelController());
final String vendorId;

   ImportExcelPage({super.key, required this.vendorId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: isArabicLocale()?  '💾 استيراد البيانات من Excel':'Import Data From Excel 💾'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
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
                         Text('📥 قم بإضافة بياناتك بنفس الترتيب في النموذج ثم احذف عناوين الحقول واحفظ الملف في هاتفك.'),
                     SizedBox(height: 20),
                  CustomButtonBlack(text: isArabicLocale()?  'تحميل النموذج' :'download',onTap:  () => controller.downloadExcelFile(),),
                
                 SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                controller.pickFile(vendorId);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('📤 رفع ملف Excel'),
                 // Icon(CupertinoIcons.add)
                ],
              ),
            ),
            SizedBox(height: 20),
            Obx(() => controller.filePath.value.isNotEmpty
                ? Text('✅ الملف: ${controller.filePath.value}')
                : Text('⚠️ لم يتم اختيار ملف بعد!')),
            SizedBox(height: 20),
        
                ],
              ),
            ),
           
        
            Obx(() => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                 scrollDirection: Axis.horizontal, 
                child: DataTable(
                 
                      headingRowColor: MaterialStateProperty.all(Colors.blue.shade200), // خلفية عناوين الأعمدة
                      dataRowColor: MaterialStateProperty.resolveWith<Color?>(
            (states) => states.contains(MaterialState.selected) ? Colors.blue.shade100 : null,
                      ), 
                   border: TableBorder.all(color: Colors.grey, width: 1),
                  columns: [
                     DataColumn(label: buildCell('Title')),
                      DataColumn(label: buildCell('description')),
                    DataColumn(label: buildCell('المنتج')),
                     DataColumn(label: buildCell('الوصف')),
                    DataColumn(label: buildCell('السعر')),
                    DataColumn(label: buildCell('سعر الخصم')),             
                        DataColumn(label: buildCell('تعديل')),
                  ],
                  rows: controller.products.map((product) => DataRow(
                    cells: [
                       DataCell(buildCell(product.title)),
                        DataCell(buildCell(product.description!)),
                        DataCell(buildCell(product.arabicTitle)),
                         DataCell(buildCell(product.arabicDescription!)),
                           DataCell(buildCell(product.price.toString())),
                            DataCell(buildCell(product.salePrice.toString())),
                          
                    
                      DataCell(IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                  
                  
                        }
                      )),
                    ],
                  )).toList(),
                ),
              ),
            )),
        

        SizedBox(height: 30,)
            // Expanded(
            //   child: Obx(
            //     () => ListView.builder(
            //       itemCount: controller.excelData.length,
            //       itemBuilder: (context, index) {
            //         return ListTile(
            //           title: Text(controller.excelData[index].join(' | ')),
            //         );
            //       },
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }



  Text buildCell(String cell) {
    return Text(cell,style: titilliumRegular.copyWith(fontSize: 14),);
  }
}
