import 'package:intl/intl.dart';

class TFormatter {

  static String formateDate(DateTime? date) {
    date ??= DateTime.now();

    return DateFormat('dd-MM-yyyy').format(date);
  }
  static String formateNumber(double value) {
   
  final formatter = NumberFormat("#,##0", "en_US"); // صياغة الرقم مع الفواصل
   return formatter.format(value);
  }

  // static String formatedPhoneNumber(String phoneNumber){

  // }
}
