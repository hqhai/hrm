import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemDepartmentAndPositionProfile extends StatelessWidget {
  const ItemDepartmentAndPositionProfile(
      {super.key, this.departmentNames = const [], this.positionNames = const []});

  final List<String> departmentNames;
  final List<String> positionNames;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: height * 0.05*departmentNames.length,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: departmentNames.length,
              itemBuilder: (context, index) => Container(
                width: width * 0.5,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      departmentNames[index],
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: height * 0.05*positionNames.length,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: positionNames.length,
              itemBuilder: (context, index) => Container(
                width: width * 0.5,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      positionNames[index],
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
