import 'package:flutter/material.dart';
import 'package:winto/core/functions/lang_f.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/appbar/custom_app_bar.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen(
      {super.key,
      required this.englishText,
      required this.englishTitle,
      required this.arabicText,
      required this.arabicTitle});

  final String arabicText;
  final String englishText;
  final String arabicTitle;
  final String englishTitle;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            title: isLocaleEn(context) ? englishTitle : arabicTitle),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Wrap(
                  children: [
                    Text(isLocaleEn(context) ? englishText : arabicText)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
