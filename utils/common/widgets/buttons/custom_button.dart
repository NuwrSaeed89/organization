import 'package:flutter/material.dart';
import 'package:winto/core/constants/text_styles.dart';

class CustomButtonBlack extends StatelessWidget {
  CustomButtonBlack({
    super.key,
    this.onTap,
    this.width = 150,
    required this.text,
  });

  final VoidCallback? onTap;
  final String text;
  double width;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Center(
          child: Container(
            width: width,
            padding: const EdgeInsets.fromLTRB(5, 7, 5, 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                text,
                style: bodyText1.copyWith(color: Colors.white),
              ),
            ),
          ),
        ));
  }
}
