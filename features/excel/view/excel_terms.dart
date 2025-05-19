import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/features/excel/view/widgets/expanded_cell.dart';
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
     controller.fetchTemporaryData(vendorId);
    return Scaffold(
    floatingActionButton: Column(
      mainAxisSize: MainAxisSize.min,
      children: [ FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () => controller.saveChanges(),
      ),
      SizedBox(height: 20,),
        FloatingActionButton(
          child: Icon(Icons.refresh),
          onPressed: () => controller.refreshData(vendorId),
        ),
      ],
    ),

      appBar: CustomAppBar(title: isArabicLocale()?  '💾 استيراد البيانات من Excel':'Import Data From Excel 💾'),
      body: SafeArea(
        child: SingleChildScrollView(
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
                   
                sortColumnIndex: controller.sortColumn.value.isNotEmpty
                    ? ["Title", "Description"].indexOf(controller.sortColumn.value)
                    : null,
                sortAscending: controller.sortAscending.value,
                        headingRowColor: MaterialStateProperty.all(Colors.blue.shade200), // خلفية عناوين الأعمدة
                        dataRowColor: MaterialStateProperty.resolveWith<Color?>(
              (states) => states.contains(MaterialState.selected) ? Colors.blue.shade100 : null,
                        ), 
                     border: TableBorder.all(color: Colors.grey, width: 1),
                    columns: [
                       DataColumn(label: Row(
                         children: [
                           buildCell('Title'),
                            IconButton(
                          icon: Icon(
                            controller.sortColumn.value == "Title"
                                ? (controller.sortAscending.value ? Icons.arrow_upward : Icons.arrow_downward)
                                : Icons.sort,
                          ),
                          onPressed: () => controller.sortData("Title"),
                        ),
                         ],
                       )),
                        DataColumn(label:
                         Row(
                           children: [
                             buildCell('Description'),
                               IconButton(
                          icon: Icon(
                            controller.sortColumn.value == "Description"
                                ? (controller.sortAscending.value ? Icons.arrow_upward : Icons.arrow_downward)
                                : Icons.sort,
                          ),
                          onPressed: () => controller.sortData("Description"),
                        ),
                           ],
                         )),
                      DataColumn(label:
                       Row(
                         children: [
                           buildCell('المنتج'),
                        //    IconButton(
                        //   icon: Icon(
                        //     controller.sortColumn.value == "3"
                        //         ? (controller.sortAscending.value ? Icons.arrow_upward : Icons.arrow_downward)
                        //         : Icons.sort,
                        //   ),
                        //   onPressed: () => controller.sortData("3"),
                        // ),
                         ],
                       )),
                       DataColumn(label:
                        Row(
                          children: [
                            buildCell('الوصف'),
                        //       IconButton(
                        //   icon: Icon(
                        //     controller.sortColumn.value == "4"
                        //         ? (controller.sortAscending.value ? Icons.arrow_upward : Icons.arrow_downward)
                        //         : Icons.sort,
                        //   ),
                        //   onPressed: () => controller.sortData("4"),
                        // ),
                          ],
                        )),
                      DataColumn(label:
                       Row(
                         children: [
                           buildCell('السعر'),
                        //     IconButton(
                        //   icon: Icon(
                        //     controller.sortColumn.value == "5"
                        //         ? (controller.sortAscending.value ? Icons.arrow_upward : Icons.arrow_downward)
                        //         : Icons.sort,
                        //   ),
                        //   onPressed: () => controller.sortData("5"),
                        // ),
                         ],
                       )),
                      DataColumn(label:
                       Row(
                         children: [
                           buildCell('سعر الخصم'),
                        //     IconButton(
                        //   icon: Icon(
                        //     controller.sortColumn.value == "6"
                        //         ? (controller.sortAscending.value ? Icons.arrow_upward : Icons.arrow_downward)
                        //         : Icons.sort,
                        //   ),
                        //   onPressed: () => controller.sortData("6"),
                        // ),
                         ],
                       )),             
                         // DataColumn(label: buildCell('تعديل')),
                    ],
                     rows: List.generate(controller.products.length, (index) {
                  var product = controller.products[index];
                  return DataRow(cells: [
                    DataCell(
                      TextFormField(
                         style:  titilliumRegular.copyWith(fontSize: 14),
                        initialValue: product.title,
                        onChanged: (value) => controller.updateItem(index, "title", value),
                      ),
                    ),
                    DataCell(
                      TextFormField(
                         style:  titilliumRegular.copyWith(fontSize: 14),
                         maxLines: 2,
                        initialValue: product.description,
                     onChanged: (value) => controller.updateItem(index, "description", value),
                      ),
                    ),
                    DataCell(
                      TextFormField(
                         style:  titilliumRegular.copyWith(fontSize: 14),
                        initialValue: product.arabicTitle,
                       onChanged: (value) => controller.updateItem(index, "arabicTitle", value),
                      ),
                    ),
                   DataCell(
          AutoResizeTextField(
          
            initialText: product.arabicDescription!,
            onChanged: (value) =>controller.updateItem(index, "arabicDescription", value), 
          ),
        ),
        
                  
                    DataCell(
                      TextFormField(
                         style:  titilliumRegular.copyWith(fontSize: 14),
                         keyboardType: TextInputType.number,
                        initialValue: product.price.toString(),
                        onChanged: (value) => controller.updateItem(index, "price", value),
                      ),
                    ),
                    DataCell(
                      TextFormField(
                        style:  titilliumRegular.copyWith(fontSize: 14),
                        keyboardType: TextInputType.number,
                        initialValue: product.price.toString(),
                        onChanged: (value) => controller.updateItem(index, "salePrice", value),
                      ),
                    ),
                  ]);
                }),
                    // rows: controller.products.map((product) => DataRow(
                    //   cells: [
                    //      DataCell(buildCell(product.title)),
                    //       DataCell(buildCell(product.description!)),
                    //       DataCell(buildCell(product.arabicTitle)),
                    //        DataCell(buildCell(product.arabicDescription!)),
                    //          DataCell(buildCell(product.price.toString())),
                    //           DataCell(buildCell(product.salePrice.toString())),
                            
                      
                    //     DataCell(IconButton(
                    //       icon: Icon(Icons.edit),
                    //       onPressed: () {
                    
                    
                    //       }
                    //     )),
                    //   ],
                    // )).toList(),
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
      ),
    );
  }



  Text buildCell(String cell) {
    return Text(cell,style: titilliumRegular.copyWith(fontSize: 14),);
  }
}
