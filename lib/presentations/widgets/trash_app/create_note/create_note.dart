import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/bloc/notes/notes_system_cubit.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/custom/date_picker_cupertino.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_dialog_common.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:themes/themes.dart';

final createNoteWidgetPageRoute = GoRoute(
    path: Pages.createNoteWidget,
    name: Pages.createNoteWidget,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return CreateNoteWidget(
        note: data['note'],
      );
    });

class CreateNoteWidget extends StatefulWidget {
  const CreateNoteWidget({
    super.key,
    this.note,
  });

  final Note? note;

  @override
  State<CreateNoteWidget> createState() => _CreateNoteWidgetState();
}

class _CreateNoteWidgetState extends State<CreateNoteWidget> {
  final TextEditingController contentController = TextEditingController();
  late String checkContent, error;
  bool isShowMap = false;
  DateTime dateNote = DateTime.now();
  double latitude = 0, longitude = 0;
  late List<String> _files = const [];

  // final Completer<GoogleMapController> _controller =
  //     Completer<GoogleMapController>();

  @override
  void initState() {
    // _determinePosition();
    checkContent = '';
    contentController.text = '';
    error = '';
    if (widget.note != null) {
      dateNote = widget.note?.dateTime ?? DateTime.now();
      checkContent = widget.note?.note ?? "";
      contentController.text = widget.note?.note ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    contentController.dispose();
    _files = [];
    super.dispose();
  }

  _listener(BuildContext context, NotesState state) {
    final appLocalizations = AppLocalizations.of(context)!;
    setState(() {
      if (state.status == NoteStatus.createNoteSuccess) {
        successDialog(context);
        error = '';
      } else if (state.status == NoteStatus.createNoteError) {
        unsuccessfulDialog(context);
        error = '';
      } else if (state.status == NoteStatus.createNoteErrorAlreadyExistOnDay) {
        successFullDialog(
            context, "${appLocalizations.youMadeANoteOnTheDate} $dateNote");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: widget.note != null
          ? AppBar(
              title: Text(
                formatDMY(widget.note!.dateTime.toString()),
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x5,
                ),
              ),
              iconTheme: IconThemeData(color: colors.text),
              actions: [
                IconButton(
                    icon: Icon(
                      Icons.map,
                      size: 24,
                      color: colors.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        isShowMap = true;
                      });
                    })
              ],
            )
          : null,
      body: BlocListener<NoteSystemCubit, NotesState>(
        listener: (context, state) => _listener(context, state),
        listenWhen: (previous, current) => previous.status != current.status,
        child: Container(
          margin: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          padding: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpacingUnit.x4),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SpacingUnit.x4_5),
                Text(
                  appLocalizations.reviewDate,
                  style: TextStyle(
                    fontSize: SpacingUnit.x4_5,
                    color: colors.text,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                DatePickerLoop(
                  oldDate: dateNote,
                  onChange: (value) => setState(
                    () {
                      dateNote = value;
                    },
                  ),
                ),
                const SizedBox(height: SpacingUnit.x4),
                // if (isShowMap) ...[
                //   Text(
                //     appLocalizations.destination,
                //     style: TextStyle(
                //       color: colors.text,
                //       fontSize: SpacingUnit.x4_5,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // SizedBox(
                //   height: SpacingUnit.x60,
                //   child: Padding(
                //     padding:
                //         const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                //     child: ClipRRect(
                //       borderRadius: const BorderRadius.all(
                //           Radius.circular(SpacingUnit.x2)),
                //       child: GoogleMap(
                //         gestureRecognizers: {
                //           Factory<PanGestureRecognizer>(
                //               () => PanGestureRecognizer())
                //         },
                //         onMapCreated: (GoogleMapController controller) {
                //           _controller.complete(controller);
                //         },
                //         myLocationEnabled: true,
                //         initialCameraPosition: CameraPosition(
                //           target: LatLng(latitude, longitude),
                //           zoom: 15,
                //         ),
                //         mapType: MapType.normal,
                //       ),
                //     ),
                //   ),
                // ),
                // ],
                Text(
                  appLocalizations.note,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4_5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: SpacingUnit.x4),
                AppInputArea(
                  minLines: 10,
                  maxLines: 10,
                  placeHolder: appLocalizations.content,
                  controller: contentController,
                  onChange: (value) => setState(() => checkContent = value),
                  error: error,
                ),
                const SizedBox(height: SpacingUnit.x4_5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      appLocalizations.attachedFiles,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    InkWell(
                      onTap: () => _getFile(),
                      child: SvgPicture.asset(
                        Assets.images.icon.activateIcon.loadFile,
                        colorFilter:
                            ColorFilter.mode(colors.text, BlendMode.srcIn),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingUnit.x5),
                Column(
                  children: List<Widget>.generate(
                    _files.length,
                    (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _files[index].split('/').last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SpacingUnit.x0_5),
                          child: InkWell(
                            onTap: () => _deleteFile(index),
                            child: Icon(
                              size: SpacingUnit.x6,
                              Icons.cancel,
                              color: colors.text.withOpacity(0.5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: SpacingUnit.x4),
                AppButton(
                  color: colors.blue,
                  colorText: colors.background,
                  title: widget.note != null
                      ? appLocalizations.update
                      : appLocalizations.create,
                  onSubmit: () => _createNote(
                      context: context,
                      note: contentController.text,
                      dateTime: dateNote),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _updateNote(
      {required BuildContext context,
      required String note,
      required String id,
      required DateTime dateTime}) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (_checkTextField()) {
      dI<NoteSystemCubit>()
          .updateNotesEvent(id: id, note: note, dateTime: dateTime);
    } else {
      setState(() {
        error = appLocalizations.theContentAndTitleCannotBeLeftBlank;
      });
    }
  }

  bool _checkTextField() {
    return checkContent != '';
  }

  _createNote(
      {required BuildContext context,
      required String note,
      required DateTime dateTime}) async {
    final appLocalizations = AppLocalizations.of(context)!;
    DateTime now = DateTime.now();
    if (widget.note != null) {
      updateNoteDialog(
        context: context,
        callBack: () => _updateNote(
          context: context,
          id: widget.note?.id ?? '',
          dateTime: dateTime,
          note: note,
        ),
        title: appLocalizations.doYouWantToUpdateANote,
      );
    } else {
      if (checkContent != '') {
        if (dateNote.isBefore(DateTime(now.year, now.month, now.day))) {
          setState(() {
            error = appLocalizations.theNoteDateCannotBeBeforeThePresentTime;
          });
        } else {
          if (dI<AuthBloc>().state.status == AuthStatus.ignoreLogin) {
            dI<NoteSystemCubit>()
                .createNotesLocalEvent(note: note, dateTime: dateTime);
          } else {
            dI<NoteSystemCubit>()
                .createNotesEvent(note: note, dateTime: dateTime);
          }
        }
      } else {
        setState(() {
          error = appLocalizations.theContentAndTitleCannotBeLeftBlank;
        });
      }
    }
  }

  void _deleteFile(int index) {
    _files.removeAt(index);
    setState(() {});
  }

  Future<void> _getFile() async {
    AndroidDeviceInfo? androidDeviceInfo;
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }
    Map<Permission, PermissionStatus> statuses = Platform.isIOS
        ? await [
            Permission.storage,
          ].request()
        : await [
            int.parse(androidDeviceInfo?.version.release ?? '12') < 13
                ? Permission.storage
                : Permission.photos,
          ].request();
    if (statuses.containsValue(PermissionStatus.permanentlyDenied) ||
        statuses.containsValue(PermissionStatus.denied)) {
      await openAppSettings();
      return;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'png'],
    );

    if (result != null) {
      final dataPaths = result.files.map((e) => e.path ?? '').toList();
      final newFile = [..._files];
      newFile.addAll(dataPaths);
      _files = newFile;
      setState(() {});
    }
  }
}
