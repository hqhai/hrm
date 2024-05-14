import 'dart:convert';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/explanation/create_explanation_config_request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

final getExplanationRequestPageRoute = GoRoute(
    name: Pages.getExplanationRequest,
    path: Pages.getExplanationRequest,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return RequestExplanationPage(
        id: data['id'],
      );
    });

class RequestExplanationPage extends StatefulWidget {
  const RequestExplanationPage({super.key, required this.id});

  final String id;

  @override
  State<RequestExplanationPage> createState() => _RequestExplanationPageState();
}

class _RequestExplanationPageState extends State<RequestExplanationPage> {
  final TextEditingController noteController = TextEditingController();
  String title = '', content = '', createDate = '', idRequest = '', result = '', note = '';

  listener(RequestState state) {
    if (state.status == RequestStatus.getRequestByIdSuccess) {
      setState(() {
        result = formatHMS(
            CreateExplanationConfigRequest.fromJson(json.decode(state.request.configStr ?? ''))
                .lateDay);
        title = state.request.title ?? '';
        content = state.request.content ?? '';
        createDate = DateFormat('yyyy-MM-dd HH:mm:ss')
            .format(DateTime.parse(state.request.createdDate ?? ''));
        idRequest = state.request.createdUserId;
        note = state.request.note ?? '';
      });
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    dI<RequestBloc>().add(GetRequestByIdEvent(id: widget.id));
    noteController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<RequestBloc, RequestState>(
          listener: (context, state) => listener(state),
          child: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x4, vertical: SpacingUnit.x4),
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: CustomsColor.colorBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(SpacingUnit.x5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appLocalizations.createTime,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: SpacingUnit.x4_5,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x4_5,
                          ),
                          Text(
                            createDate,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x4_5,
                          ),
                          Text(
                            appLocalizations.title,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: SpacingUnit.x4_5,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x3,
                          ),
                          Text(
                            title,
                            maxLines: 3,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x6_5,
                          ),
                          Text(
                            appLocalizations.content,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: SpacingUnit.x4_5,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x3,
                          ),
                          Text(
                            content,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x6_5,
                          ),
                          Text(
                            appLocalizations.lateTime,
                            style: const TextStyle(
                              color: Colors.orange,
                              fontSize: SpacingUnit.x4_5,
                            ),
                          ),
                          const SizedBox(
                            height: SpacingUnit.x3,
                          ),
                          Text(
                            result,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x4,
                            ),
                          ),
                          note != ''
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: SpacingUnit.x6_5,
                                    ),
                                    Text(
                                      appLocalizations.note,
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: SpacingUnit.x4_5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x3,
                                    ),
                                    Text(
                                      note,
                                      style: TextStyle(
                                        color: colors.text,
                                        fontSize: SpacingUnit.x4,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ],
                      ),
                      const SizedBox(
                        height: SpacingUnit.x4_5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
