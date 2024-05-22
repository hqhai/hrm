import 'dart:io';
import 'dart:typed_data';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

final requestUpdatePageRoute = GoRoute(
    name: Pages.requestUpdatePage,
    path: Pages.requestUpdatePage,
    builder: (context, GoRouterState state) {
      return const RequestUpdatePage();
    });

class RequestUpdatePage extends StatefulWidget {
  const RequestUpdatePage({
    super.key,
    /*required this.request*/
  });

  //final Request request;

  @override
  State<RequestUpdatePage> createState() => _RequestUpdatePageState();
}

class _RequestUpdatePageState extends State<RequestUpdatePage> {
  String dropdownPriorityValue = '';
  String dropdownApproverValue = '';
  final TextEditingController titleController = TextEditingController(),
      contentController = TextEditingController();
  String title = '', content = '';
  late String pathImage;
  late File file;
  late Request request;
  Uint8List? imageData;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    request = dI<RequestBloc>().state.request;
    dI<RequestBloc>().add(GetRequestByIdEvent(id: request.id));
    dropdownPriorityValue = request.priority ?? '';
    titleController.text = request.title ?? '';
    contentController.text = request.content ?? '';
    pathImage = '';
    file = File('');
    super.initState();
  }

  String formatDate(String time) {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  _listener(BuildContext context, RequestState state) {
    if (state.status == RequestStatus.updateRequestSuccess) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == RequestStatus.updateRequestInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    }
    if (state.status == RequestStatus.updateRequestError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) => _listener(context, state),
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
                          request.createdDate != null
                              ? formatDate(state.request.createdDate ?? '')
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
                          request.createdFullName ?? '',
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
                          request.phoneNumber ?? '',
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
                          request.type ?? '',
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
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          child: Text(
                            appLocalizations.priority,
                            style:
                                const TextStyle(fontSize: SpacingUnit.x4_5, color: Colors.orange),
                          ),
                        ),
                        DropdownMenu<String>(
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          initialSelection: dropdownPriorityValue,
                          onSelected: (String? value) {
                            setState(() {
                              dropdownPriorityValue = value!;
                            });
                          },
                          dropdownMenuEntries: MenuValues.listPriority
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(value: value, label: value);
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x6_5,
                    ),
                    if (request.type == TypeRequestStatus.cRM.name)
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
                              approverName(request.approverId ?? '') ?? "",
                              style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                            ),
                          ),
                        ],
                      ),
                    if (request.type == TypeRequestStatus.cRM.name)
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
                    AppInput(
                      placeHolder: appLocalizations.title,
                      controller: titleController,
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
                    AppInputArea(
                      minLines: 10,
                      maxLines: 10,
                      placeHolder: appLocalizations.leaveACommentHere,
                      controller: contentController,
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
                      mainAxisAlignment:
                          kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => _checkSelectImage(),
                          icon: Icon(
                            Icons.file_copy,
                            size: SpacingUnit.x10,
                            color: colors.text,
                          ),
                        ),
                        _image(state),
                      ],
                    ),
                    const SizedBox(
                      height: SpacingUnit.x4_5,
                    ),
                    dI<UserBloc>().state.user.id == ConfigStringValues.user.name
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () => _updateDialog(context),
                            child: Text(
                              appLocalizations.save,
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

  Widget _image(RequestState state) {
    if (_checkPathImage(state)) {
      return SizedBox(
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
      );
    } else if (!kIsWeb) {
      if (pathImage != '') {
        return SizedBox(
          height: SpacingUnit.x50,
          width: SpacingUnit.x50,
          child: Image.file(
            File(pathImage),
            fit: BoxFit.fill,
          ),
        );
      } else {
        return const SizedBox();
      }
    } else {
      if (imageData != null) {
        return SizedBox(
          height: SpacingUnit.x50,
          width: SpacingUnit.x50,
          child: Image.memory(
            imageData!,
            fit: BoxFit.fill,
          ),
        );
      } else {
        return const SizedBox();
      }
    }
  }

  _checkSelectImage() {
    if (kIsWeb) {
      getImagePathByWeb();
    } else {
      getImagePath();
    }
  }

  bool _checkPathImage(RequestState state) {
    return request.filePaths?.isNotEmpty == true &&
        state.request.filePaths != [''] &&
        pathImage == '' &&
        imageData == null;
  }

  _updateDialog(BuildContext context) {
    updateRequestDialog(
      context,
      () {
        pathImage != ''
            ? dI<RequestBloc>().add(
                UpdateRequestByIdEvent(
                  id: request.id,
                  priority: dropdownPriorityValue,
                  file: file,
                  content: contentController.text,
                  title: titleController.text,
                  imageData: imageData,
                  path: const [],
                ),
              )
            : request.filePaths?.isNotEmpty == true
                ? dI<RequestBloc>().add(
                    UpdateRequestByIdEvent(
                      id: request.id,
                      priority: dropdownPriorityValue,
                      file: file,
                      content: contentController.text,
                      title: titleController.text,
                      imageData: imageData,
                      path: request.filePaths!,
                    ),
                  )
                : dI<RequestBloc>().add(
                    UpdateRequestByIdEvent(
                      id: request.id,
                      priority: dropdownPriorityValue,
                      file: file,
                      content: contentController.text,
                      title: titleController.text,
                      imageData: imageData,
                      path: const [],
                    ),
                  );
      },
    );
  }

  Future<void> getImagePathByWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      setState(() {
        file = File.fromRawPath(result.files.first.bytes!);
        imageData = result.files.first.bytes!;
      });
    } else {
      setState(() {
        imageData = null;
      });
    }
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

  String? approverName(String id) {
    return dI<UserByRolesBloc>().state.users.where((e) => e.id == id).first.fullName;
  }
}
