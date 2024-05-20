import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemContentProfile extends StatelessWidget {
  const ItemContentProfile({super.key, required this.content1, required this.content2});

  final String content1;
  final String content2;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                width: width * 0.5,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  content1,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                ),
              ),
            ),
            const SizedBox(width: SpacingUnit.x3,),
            Expanded(
              child: Container(
                width: width * 0.5,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  content2,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x4_5,
        ),
      ],
    );
  }
}
