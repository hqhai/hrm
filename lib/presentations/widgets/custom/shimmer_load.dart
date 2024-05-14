import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoad extends StatelessWidget {
  const ShimmerLoad({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.indigo,
      highlightColor: Colors.indigoAccent,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            width: MediaQuery.sizeOf(context).width,
            color: Colors.amber,
            margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          );
        },
      ),
    );
  }
}
