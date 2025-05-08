// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:winto/features/organization/e_commerce/utils/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:winto/features/organization/e_commerce/utils/constants/color.dart';

class TStaticsCard extends StatelessWidget {
  const TStaticsCard(
      {super.key,
      required this.title,
      required this.number,
      required this.icon});
  final String title;
  final String number;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      radius: BorderRadius.circular(25),
      // backgroundColor: RadialGradient(TColors.linerCardGradient, colors: []),
      child: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
