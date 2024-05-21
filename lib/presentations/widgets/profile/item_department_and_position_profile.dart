import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemDepartmentAndPositionProfile extends StatelessWidget {
  const ItemDepartmentAndPositionProfile(
      {super.key, this.departmentNames = const [], this.positionNames = const [], this.check = true});

  final List<String> departmentNames;
  final List<String> positionNames;
  final bool check;

  List<String> setList(){
    Set<String> set = Set<String>.from(departmentNames);
    return set.toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: height * 0.05 * setList().length,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: setList().length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: SpacingUnit.x1_5, bottom: SpacingUnit.x1_5),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      setList()[index],
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: colors.text, fontSize: check ? SpacingUnit.x3 : SpacingUnit.x4),
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
            height: height * 0.05 * positionNames.length,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: positionNames.length,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(left: SpacingUnit.x1_5, bottom: SpacingUnit.x1_5),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      positionNames[index],
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(color: colors.text, fontSize: check ? SpacingUnit.x3 : SpacingUnit.x4),
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
