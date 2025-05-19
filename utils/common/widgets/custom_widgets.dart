import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';
import 'package:winto/features/organization/e_commerce/utils/formatters/formatter.dart';

class TCustomWidgets {
  static Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 3),
      child: Divider(
        thickness: .5,
      ),
    );
  }
 static Widget buildLabel(String text){
  
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 8,),
          Text(text, style:   titilliumBold),
        ],
      ),
    );
}




static Widget formattedPrice(double value, String currency,double size) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: size, color:TColors.primary,fontFamily: 'Poppins'), // حجم الرقم الأساسي
      children: [
        TextSpan(text: TFormatter.formateNumber(value)), // الرقم المنسق
        TextSpan(
          text: " $currency", // العملة
          style: TextStyle(fontSize: size-3, color:TColors.primary, fontFamily: 'Poppins'), // حجم أصغر للعملة
        ),
      ],
    ),
  );
}




 static Widget viewSalePrice(String text, double  size) {
    return Text(  TFormatter.formateNumber(double.parse(text)),
        // PriceConverter.convertPrice(
        //     context, product.unitPrice),
        style: titilliumBold.copyWith(
            color: TColors.darkGrey,fontFamily: 'Poppins',
           decoration: TextDecoration.lineThrough,
          //  decorationStyle: ,
            decorationThickness: 1.5,
            fontSize: size));
  }


  static Padding buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16),
      child: Text(
        text,
        style: titilliumBold.copyWith(fontSize: 22, height: .5),
      ),
    );
  }
}
