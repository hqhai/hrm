import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

final requestDefaultPageRoute = GoRoute(
    name: Pages.requestDefault,
    path: Pages.requestDefault,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return RequestPage(
        id: data['id'],
      );
    });

class RequestPage extends StatefulWidget {
  const RequestPage({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  String dropdownPriorityValue = '',
      dropdownApproverValue = '',
      titleController = '',
      commentsController = '';

  late String pathImage;
  late File file;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    dI<RequestBloc>().add(GetRequestByIdEvent(id: widget.id));

    pathImage = '';
    file = File('');
    super.initState();
  }

  String formatDate(String time) {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  _listener(RequestState state) {
    if (state.status == RequestStatus.getRequestByIdSuccess ||
        state.status == RequestStatus.updateRequestSuccess) {
      titleController = state.request.title??'';
      commentsController = state.request.content??'';
      dropdownPriorityValue = state.request.priority??'';
    }
    if(state.status == RequestStatus.updateRequestSuccess){
      dI<RequestBloc>().add(GetRequestByIdEvent(id: widget.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          _listener(state);
        },
        listenWhen: (previous, current) => previous.status != current.status,
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return Container(
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              color: CustomsColor.colorBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(SpacingUnit.x5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.createTime,
                          style: const TextStyle(fontSize: SpacingUnit.x4_5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x3_5,
                        ),
                        Text(
                          state.request.createdDate != null
                              ? formatDate(state.request.createdDate??'')
                              : '',
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: SpacingUnit.x4_5,
                            color: colors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.creator,
                          style: const TextStyle(fontSize: SpacingUnit.x4_5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x3_5,
                        ),
                        Text(
                          state.request.createdFullName ?? '',
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: SpacingUnit.x4_5,
                            color: colors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.phoneNumber,
                          style: const TextStyle(fontSize: SpacingUnit.x4_5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x3_5,
                        ),
                        Text(
                          state.request.phoneNumber ?? '',
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: SpacingUnit.x4_5,
                            color: colors.text,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.typeRequest,
                          style: const TextStyle(fontSize: SpacingUnit.x4_5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x3_5,
                        ),
                        Text(
                          state.request.type ?? '',
                          style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appLocalizations.priority,
                          style: const TextStyle(fontSize: SpacingUnit.x4_5, color: Colors.orange),
                        ),
                        const SizedBox(
                          width: SpacingUnit.x3_5,
                        ),
                        Text(
                          dropdownPriorityValue,
                          style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x6_5,
                    ),
                    if (state.request.type == TypeRequestStatus.cRM.name)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            child: Text(
                              appLocalizations.approver,
                              style:
                                  const TextStyle(fontSize: SpacingUnit.x4_5, color: Colors.orange),
                            ),
                          ),
                          const SizedBox(
                            width: SpacingUnit.x3_5,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: Text(
                              textAlign: TextAlign.right,
                              approverName(state.request.approverId??''),
                              style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                            ),
                          ),
                        ],
                      ),
                    if (state.request.type == TypeRequestStatus.cRM.name)
                      const SizedBox(
                        height: SpacingUnit.x6_5,
                      ),
                    Text(
                      appLocalizations.title,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: SpacingUnit.x4_5,
                      ),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    Text(
                      titleController,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4_5,
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
                      height: SpacingUnit.x4_5,
                    ),
                    Text(
                      commentsController,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4_5,
                      ),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    Text(
                      appLocalizations.selectFile,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: SpacingUnit.x4_5,
                      ),
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        state.request.filePaths?.isNotEmpty == true &&
                                state.request.filePaths != ['']
                            ? SizedBox(
                                height: SpacingUnit.x50,
                                width: SpacingUnit.x50,
                                child: Image.network(
                                  state.request.filePaths!.first,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      Assets.images.error.imageError.path,
                                      fit: BoxFit.fill,
                                    );
                                  },
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    dI<UserBloc>().state.user.role == ConfigStringValues.user.name &&
                            state.request.status == StatusRequestStatus.pending.name
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              dI<AppNavigation>().pushName(context,
                                  page: Pages.requestUpdatePage,);
                            },
                            child: Text(
                              appLocalizations.update,
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x4,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> getImagePath() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        pathImage = pickedFile.path;
        file = File(pathImage);
      });
    } else {
      pathImage = '';
    }
  }

  String approverName(String id) {
    List<User> users = dI<UserByRolesBloc>().state.users.where((e) => e.id == id).toList();
    if(users.isNotEmpty) {
      return dI<UserByRolesBloc>().state.users.where((e) => e.id == id).first.fullName;
    }
    else{
      return '';
    }
  }
}
