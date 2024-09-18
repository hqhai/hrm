import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/custom/date_picker_cupertino.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_dialog_common.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  DateTime dateNote = DateTime.now();
  double latitude = 0, longitude = 0;
  Position? _currentLocation;
  LatLng? latLngFsel;
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  void initState() {
    _determinePosition();
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
    super.dispose();
    contentController.dispose();
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
        successFullDialog(context, "${appLocalizations.youMadeANoteOnTheDate} $dateNote");
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
            )
          : null,
      body: BlocListener<NotesBloc, NotesState>(
        listener: (context, state) => _listener(context, state),
        listenWhen: (previous, current) => previous.status != current.status,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
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
                  appLocalizations.dateNote,
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
                Text(
                  appLocalizations.destination,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4_5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: SpacingUnit.x60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x2)),
                      child: GoogleMap(
                        gestureRecognizers: {
                          Factory<PanGestureRecognizer>(() => PanGestureRecognizer())
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(latitude, longitude),
                          zoom: 15,
                        ),
                        mapType: MapType.normal,
                      ),
                    ),
                  ),
                ),
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
                AppButton(
                  color: colors.blue,
                  colorText: colors.background,
                  title: widget.note != null ? appLocalizations.update : appLocalizations.create,
                  onSubmit: () => _createNote(
                      context: context, note: contentController.text, dateTime: dateNote),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _determinePosition() async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(appLocalizations.locationServicesAreDisabled);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(appLocalizations.locationPermissionsAreDenied);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (!currentContext.mounted) return;
      showDialog(
        context: currentContext,
        builder: (BuildContext context) {
          return const Dialog(
            child: DialogOpenSetting(),
          );
        },
      );
    }
    final position = await Geolocator.getCurrentPosition();
    _setCurrentLocation(position: position);
  }

  _setCurrentLocation({required Position position}) {
    setState(() {
      _currentLocation = position;
      double lo = _currentLocation?.longitude ?? 0;
      double la = _currentLocation?.latitude ?? 0;
      latLngFsel = LatLng(la, lo);
      _goToTheLake();
    });
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    final cameraMan = CameraPosition(
      target: latLngFsel ?? const LatLng(0, 0),
      zoom: 20,
    );
    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraMan));
  }

  _updateNote(
      {required BuildContext context,
      required String note,
      required String id,
      required DateTime dateTime}) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (_checkTextField()) {
      dI<NotesBloc>().add(UpdateNotesEvent(id: id, note: note, dateTime: dateTime));
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
      {required BuildContext context, required String note, required DateTime dateTime}) async {
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
          dI<NotesBloc>().add(CreateNotesEvent(note: note, dateTime: dateTime));
        }
      } else {
        setState(() {
          error = appLocalizations.theContentAndTitleCannotBeLeftBlank;
        });
      }
    }
  }
}

class DialogOpenSetting extends StatelessWidget {
  const DialogOpenSetting({super.key});

  _onClose(context) {
    Navigator.pop(context);
  }

  _openSetting(context) {
    Navigator.pop(context);
    Geolocator.openLocationSettings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.sizeOf(context).height / 4.5,
      padding: const EdgeInsets.all(SpacingUnit.x4),
      decoration: BoxDecoration(
          color: colors.background, borderRadius: BorderRadius.circular(SpacingUnit.x4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _onClose(context);
            },
            child: Container(
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.topRight,
                child: const Icon(Icons.close)),
          ),
          const SizedBox(height: SpacingUnit.x3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x10),
            child: Text(
              appLocalizations.contentPopUpOpenGPS,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: SpacingUnit.x4),
          AppButton(
            title: appLocalizations.allow,
            onSubmit: () => _openSetting(context),
          )
        ],
      ),
    );
  }
}
