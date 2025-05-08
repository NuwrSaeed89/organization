import 'package:flutter/material.dart';
import 'package:winto/features/organization/e_commerce/utils/common/widgets/shimmers/shimmer.dart';

class TProductHorizentalShimmer extends StatelessWidget {
  const TProductHorizentalShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => TShimmerEffect(
              width: 110,
              height: 180,
            ),
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(
              width: 8,
            ));
  }
}
