
import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/pages/activate/requisition_follower/content_item_follwer_requisition_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

import '../../../widgets/custom/container_border.dart';

class ItemRequisitionFollowerList extends StatefulWidget {
  const ItemRequisitionFollowerList({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ItemRequisitionFollowerList> createState() => _ItemRequisitionFollowerListState();
}

class _ItemRequisitionFollowerListState extends State<ItemRequisitionFollowerList> {
  bool checkOpacity = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
        child: ContainerBorder(
          borderColors: colors.background,
          backgroundColors: colors.background,
          child: GestureDetector(
            onTap: () => nextScreenRequest(
              context: context,
              id: widget.id,
              checkOpacity: checkOpacity,
              setState: () => setOpacity(),
              checkUser: RequestSeeByWho.followers,
            ),
            child: Stack(
              children: [
                Opacity(
                  opacity: checkOpacity ? 1 : 0,
                  child: Center(
                    child: Lottie.asset(Assets.images.icon.loading,
                        width: SpacingUnit.x20, height: SpacingUnit.x20, fit: BoxFit.fill),
                  ),
                ),
                Opacity(
                  opacity: checkOpacity ? 0.5 : 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: SpacingUnit.x2),
                    child: ContentItemRequestFollowerList(
                      id: widget.id,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
  setOpacity() {
    setState(() {
      checkOpacity = !checkOpacity;
    });
  }
}
