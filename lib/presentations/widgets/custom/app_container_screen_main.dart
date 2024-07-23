import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';

class ContainerScreenMain extends StatelessWidget {
  const ContainerScreenMain({super.key, required this.child, this.padding, this.margin});

  final double? padding, margin;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? SpacingUnit.x3),
      margin: EdgeInsets.all(margin ?? SpacingUnit.x3),
      child: child,
    );
  }
}
