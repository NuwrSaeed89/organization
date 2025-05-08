import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/sizes.dart';

class SellerInfoScreen extends StatelessWidget {
  const SellerInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(TSizes.defaultSpace), child: Column()),
      ),
    ));
  }
}
