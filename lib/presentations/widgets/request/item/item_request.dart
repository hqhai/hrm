import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequest extends StatefulWidget {
  const ItemRequest({super.key, this.index = 0});

  final int index;

  @override
  State<ItemRequest> createState() => _ItemRequestState();
}

class _ItemRequestState extends State<ItemRequest> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequestBloc, RequestState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            _pushScreen(state);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            decoration: const BoxDecoration(
              color: Color(0xff293656),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            height: _heightItem(state.requests[widget.index].title),
            child: Row(
              children: [
                Expanded(
                  flex: 15,
                  child: CircleAvatar(
                    backgroundColor: const Color(0xff42558A),
                    child: Text('${widget.index + 1}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: SpacingUnit.x6, color: colors.text)),
                  ),
                ),
                Expanded(
                  flex: 85,
                  child: Padding(
                    padding: const EdgeInsets.only(right: SpacingUnit.x2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          state.requests[widget.index].type??'',
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.orange),
                        ),
                        if (state.requests[widget.index].title != null)
                          const Divider(
                            height: 1,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Colors.blue,
                          ),
                        if (state.requests[widget.index].title != null)
                          Text(
                            state.requests[widget.index].title ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                          ),
                        if (state.requests[widget.index].title != null)
                          Text(
                            state.requests[widget.index].content ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: SpacingUnit.x4, color: colors.primary),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Text(time(context, state.requests[widget.index].createdDate??''),
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                    fontSize: SpacingUnit.x4, color: Colors.white70)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double _heightItem(String? str) {
    return str != null ? 160 : 100;
  }

  _pushScreen(RequestState state) {
    if (state.requests[widget.index].type == TypeRequestStatus.overTime.name) {
      dI<AppNavigation>().pushName(context,
          page: Pages.overTimeRequest, extra: {'id': state.requests[widget.index].id});
    } else if (state.requests[widget.index].type == TypeRequestStatus.onLeave.name) {
      dI<AppNavigation>().pushName(context,
          page: Pages.onLeaveRequest, extra: {'id': state.requests[widget.index].id});
    } else if (state.requests[widget.index].type == TypeRequestStatus.explanation.name) {
      dI<AppNavigation>().pushName(context,
          page: Pages.getExplanationRequest, extra: {'id': state.requests[widget.index].id});
    } else if (state.requests[widget.index].type == TypeRequestStatus.roomMeeting.name) {
      dI<AppNavigation>().pushName(context,
          page: Pages.roomMeetingRequestPageRoute, extra: {'id': state.requests[widget.index].id});
    } else {
      dI<AppNavigation>().pushName(context,
          page: Pages.requestDefault, extra: {'id': state.requests[widget.index].id});
    }
  }

  String time(BuildContext context, String time) {
    final appLocalizations = AppLocalizations.of(context)!;
    int d = DateTime.now().difference(DateTime.parse(time)).inHours;
    if (d < 24 && DateTime.now().day == DateTime.parse(time).day) {
      return appLocalizations.today;
    } else if ((d >= 24 && d < 48) ||
        (d < 24 && DateTime.now().day == DateTime.parse(time).day + 1)) {
      return appLocalizations.yesterday;
    } else {
      return '${d ~/ 24} ${appLocalizations.daysAgo}';
    }
  }
}
