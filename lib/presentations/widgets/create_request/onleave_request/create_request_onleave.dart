import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/request/on_leave/create_onleave_config_request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/widgets/create_request/item_create_overtime_or_onleave.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class CreateRequestOLWidget extends StatefulWidget {
  const CreateRequestOLWidget({super.key});

  @override
  State<CreateRequestOLWidget> createState() => _CreateRequestOLWidgetState();
}

class _CreateRequestOLWidgetState extends State<CreateRequestOLWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();
  String startTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      endTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      title = "",
      content = "",
      notification = '';

  @override
  void initState() {
    super.initState();
    titleController.text = '';
    commentsController.text = '';
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    commentsController.dispose();
  }

  _listener(BuildContext context, RequestState state) {
    if (state.status == RequestStatus.createRequestSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequestStatus.createRequestInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == RequestStatus.createRequestError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<RequestBloc, RequestState>(
      listener: (context, state) {
        _listener(context, state);
      },
      builder: (context, state) {
        return Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color: CustomsColor.colorBackground,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemCreateOTOrOL(
                  onChangeTitle: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  onChangeContent: (value) {
                    setState(() {
                      content = value;
                    });
                  },
                  onChangeEndTime: (value) {
                    endTime = value;
                  },
                  onChangeStartTime: (value) {
                    startTime = value;
                  },
                  title: appLocalizations.title,
                  content: appLocalizations.content,
                ),
                const SizedBox(height: SpacingUnit.x4),
                if (notification != '')
                  Text(notification,
                      style: TextStyle(fontSize: SpacingUnit.x4, color: colors.error)),
                const SizedBox(height: SpacingUnit.x4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo,
                  ),
                  onPressed: () => _onClick(context),
                  child: Text(
                    appLocalizations.create,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool _checkTextField() {
    return title != '' && content != '';
  }

  _onClick(BuildContext context) {
    if (_checkTextField()) {
      _checkNotification(context);
    }
  }

  _checkNotification(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (DateTime.parse(startTime).difference(DateTime.now()).inSeconds <= 0) {
      setState(() {
        notification = appLocalizations.bookingTimeMustBeAfterCurrentTime;
      });
    } else if (DateTime.parse(endTime).difference(DateTime.parse(startTime)).inSeconds <= 0) {
      setState(() {
        notification = appLocalizations.endTimeMustBeAfterStartTime;
      });
    } else {
      createRequestDialog(
        context,
        () {
          dI<RequestBloc>().add(
            CreateOnLeaveRequestEvent(
              type: TypeRequestStatus.onLeave.name,
              isApprove: true,
              priority: PriorityRequestStatus.high.name,
              title: title,
              content: content,
              config: CreateOnLeaveConfigRequest(
                endOnLeave: formatIso8601(endTime),
                startOnLeave: formatIso8601(startTime),
              ),
            ),
          );
        },
      );
    }
  }
}
