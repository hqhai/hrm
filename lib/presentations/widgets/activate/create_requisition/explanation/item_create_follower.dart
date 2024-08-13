import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_name/user_by_name_event.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateFollower extends StatefulWidget {
  const ItemCreateFollower({
    super.key,
    this.onChange,
    this.title,
    this.listFollower = const [],
    this.error = '',
  });

  final String? title;
  final ValueChanged<List<User>>? onChange;
  final List<User> listFollower;
  final String error;

  @override
  State<ItemCreateFollower> createState() => _ItemCreateFollowerState();
}

class _ItemCreateFollowerState extends State<ItemCreateFollower> {
  List<User> listFollower = [];

  List<User> setListFollower() {
    if (widget.listFollower.isNotEmpty && listFollower.isEmpty) {
      setState(() {
        listFollower = widget.listFollower;
      });
      return widget.listFollower;
    } else if (widget.listFollower.isNotEmpty && listFollower.isNotEmpty) {
      return listFollower;
    }
    return listFollower;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (setListFollower().isNotEmpty)
                GestureDetector(
                  onTap: () => _add(context),
                  child: Icon(
                    Icons.add,
                    color: colors.success,
                    size: SpacingUnit.x8,
                  ),
                ),
            ],
          ),
          if (!setListFollower().isNotEmpty)
            GestureDetector(
              onTap: () => _add(context),
              child: ContainerBorder(
                marginTop: 8,
                borderColors: colors.text.withOpacity(0.4),
                width: width,
                paddingVertical: SpacingUnit.x4,
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: colors.text.withOpacity(0.4),
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
            ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: setListFollower()
                .mapIndexed(
                  (index, element) => ItemUserFollower(
                    user: element,
                    callBack: () => _delete(index),
                  ),
                )
                .toList(),
          ),
          if (widget.error.isNotEmpty)
            Text(
              widget.error,
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
        ],
      ),
    );
  }

  _add(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dI<UserByNameBloc>().add(GetUserByNameEvent(completer: completer));
    final check = await completer.future;
    if (check) {
      if (!currentContext.mounted) return;
      showModalBottomSheet<void>(
        context: currentContext,
        builder: (BuildContext context) {
          return BottomSheetWidget(
            oldUser: listFollower,
            onChange: (value) => setListPerson(value),
          );
        },
      );
    }
  }

  _delete(int index) {
    setState(() {
      setState(() {
        listFollower.removeAt(index);
      });
    });
  }

  setListPerson(List<User> value) {
    setState(() {
      listFollower = value;
      widget.onChange?.call(listFollower);
    });
  }
}

class ItemUserFollower extends StatelessWidget {
  const ItemUserFollower({
    super.key,
    required this.user,
    required this.callBack,
  });

  final User user;
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      borderColors: colors.text.withOpacity(0.3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${user.fullName} - #${user.code}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
          GestureDetector(
            onTap: () => callBack.call(),
            child: Icon(
              Icons.close,
              color: colors.error,
              size: SpacingUnit.x6,
            ),
          ),
        ],
      ),
    );
  }
}
