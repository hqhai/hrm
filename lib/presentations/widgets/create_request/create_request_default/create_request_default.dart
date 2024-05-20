import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_state.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

class CreateRequestDefaultWidget extends StatefulWidget {
  const CreateRequestDefaultWidget({super.key, required this.typeRequest});

  final String typeRequest;

  @override
  State<CreateRequestDefaultWidget> createState() => _CreateRequestDefaultWidgetState();
}

class _CreateRequestDefaultWidgetState extends State<CreateRequestDefaultWidget> {
  final TextEditingController titleController = TextEditingController(),
      commentsController = TextEditingController();
  late String pathImage, checkTitle, checkContent, dropdownPriorityValue, dropdownApproverValue;
  late File file;
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();
    dI<UserByRolesBloc>().add(const GetUserByRoleEvent(role: 'manager'));
    dropdownPriorityValue = MenuValues.listPriority.first;
    checkTitle = '';
    checkContent = '';
    titleController.text = '';
    commentsController.text = '';
    pathImage = '';
    file = File('');
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
      checkTitle = '';
      checkContent = '';
      titleController.text = '';
      commentsController.text = '';
    } else if (state.status == RequestStatus.createRequestInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == RequestStatus.createRequestError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  _listenerUserByRoles(BuildContext context, UserByRolesState state) {
    if (state.status == UserStatus.getUsersByRoleSuccess) {
      dropdownApproverValue = state.users.first.fullName??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<RequestBloc, RequestState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => previous.status != current.status,
      child: BlocConsumer<UserByRolesBloc, UserByRolesState>(
        listener: (context, stateUser) => _listenerUserByRoles(context, stateUser),
        builder: (context, stateUser) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: SpacingUnit.x4_5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.priority,
                    style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                  ),
                  const SizedBox(width: SpacingUnit.x3_5),
                  DropdownMenu<String>(
                    initialSelection: MenuValues.listPriority.first,
                    onSelected: (String? value) {
                      setState(() {
                        dropdownPriorityValue = value!;
                      });
                    },
                    dropdownMenuEntries:
                        MenuValues.listPriority.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: SpacingUnit.x6_5),
              if (widget.typeRequest == TypeRequestStatus.cRM.name)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      child: Text(
                        appLocalizations.approver,
                        style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                      ),
                    ),
                    const SizedBox(width: SpacingUnit.x3_5),
                    dropdownApprover(stateUser),
                  ],
                ),
              if (widget.typeRequest == TypeRequestStatus.cRM.name)
                const SizedBox(height: SpacingUnit.x6_5),
              Text(
                appLocalizations.title,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4_5,
                ),
              ),
              const SizedBox(height: SpacingUnit.x4_5),
              AppInput(
                placeHolder: appLocalizations.title,
                controller: titleController,
                onChange: (value) => setState(() => checkTitle = value),
              ),
              const SizedBox(height: SpacingUnit.x6_5),
              Text(
                appLocalizations.content,
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4_5),
              ),
              const SizedBox(height: SpacingUnit.x4_5),
              AppInputArea(
                minLines: 10,
                maxLines: 10,
                placeHolder: appLocalizations.content,
                controller: commentsController,
                onChange: (value) => setState(() => checkContent = value),
              ),
              const SizedBox(height: SpacingUnit.x4_5),
              Text(appLocalizations.selectFile,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4_5)),
              const SizedBox(height: SpacingUnit.x4_5),
              Row(
                mainAxisAlignment:
                    kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => kIsWeb ? getImagePathByWeb() : getImagePath(),
                    icon: Icon(Icons.file_copy, size: SpacingUnit.x10, color: colors.text),
                  ),
                  removed(context),
                  imageSelect()
                ],
              ),
              const SizedBox(height: SpacingUnit.x4_5),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo),
                    onPressed: () => _createRequest(context, stateUser),
                    child: Text(appLocalizations.create,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                  ),
                  const SizedBox(width: SpacingUnit.x5),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Widget dropdownApprover(UserByRolesState stateUser) {
    return stateUser.status == UserStatus.getUsersByRoleSuccess
        ? DropdownMenu<String>(
            width: MediaQuery.sizeOf(context).width * 0.5,
            initialSelection: stateUser.users.map((e) => e.fullName).toList().first,
            onSelected: (String? value) {
              setState(
                () {
                  dropdownApproverValue = value!;
                },
              );
            },
            dropdownMenuEntries:
                stateUser.users.map((e) => e.fullName??"").toList().map<DropdownMenuEntry<String>>(
              (String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              },
            ).toList(),
          )
        : Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.5,
            ));
  }

  Widget removed(BuildContext context) {
    final colors = AppTheme.getColors(context);
    if (pathImage != '' || imageData != null) {
      return IconButton(
        onPressed: () => deleteImagePath(),
        icon: Icon(Icons.delete, size: SpacingUnit.x6, color: colors.error),
      );
    }
    return const SizedBox();
  }

  Widget imageSelect() {
    if (pathImage != '' || imageData != null) {
      return SizedBox(
        height: SpacingUnit.x50,
        width: SpacingUnit.x50,
        child: kIsWeb
            ? imageData != null
                ? Image.memory(imageData!, fit: BoxFit.fill)
                : const SizedBox()
            : Image.file(fit: BoxFit.fill, File(pathImage)),
      );
    }
    return const SizedBox();
  }

  bool _checkTextField() {
    return checkTitle != '' && checkContent != '';
  }

  _createRequest(BuildContext context, UserByRolesState state) {
    if (_checkTextField()) {
      createRequestDialog(
        context,
        () {
          if (widget.typeRequest == TypeRequestStatus.cRM.name) {
            dI<RequestBloc>().add(CreateRequestEventNeedApproval(
                type: widget.typeRequest,
                isApprove: true,
                config: '',
                content: commentsController.text,
                file: file,
                imageData: imageData,
                approverId: approver(dropdownApproverValue, state.users),
                priority: dropdownPriorityValue,
                title: titleController.text));
          } else {
            dI<RequestBloc>().add(CreateRequestEventNoNeedApproval(
              type: widget.typeRequest,
              isApprove: false,
              config: '',
              content: commentsController.text,
              file: file,
              imageData: imageData,
              priority: dropdownPriorityValue,
              title: titleController.text,
            ));
          }
        },
      );
    }
  }

  Future<void> deleteImagePath() async {
    setState(() {
      pathImage = '';
      imageData = null;
    });
  }

  Future<void> getImagePathByWeb() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
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
      setState(() {
        pathImage = '';
      });
    }
  }

  String approver(String approverName, List<User> users) {
    User u = users.where((element) => element.fullName.toString() == approverName.toString()).first;
    return users[users.indexOf(u)].id;
  }
}
