import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/common/styles/styles.dart';

class TCustomWidgets {
  static Widget buildDivider() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 3),
      child: Divider(
        thickness: .5,
      ),
    );
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
