import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notes/notes_system_cubit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themes/themes.dart';

final noteSystemPageRoute = GoRoute(
    path: Pages.noteSystem,
    name: Pages.noteSystem,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return NoteDialogSystem(
        note: data['note'],
      );
    });

class NoteDialogSystem extends StatefulWidget {
  const NoteDialogSystem({super.key, required this.note});

  final Note note;

  @override
  State<NoteDialogSystem> createState() => _NoteDialogSystemState();
}

class _NoteDialogSystemState extends State<NoteDialogSystem> {
  double latitude = 0, longitude = 0;
  LatLng? latLngFsel;

  @override
  void initState() {
    // _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          formatDMY(widget.note.dateTime.toString()),
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
        iconTheme: IconThemeData(color: colors.text),
      ),
      body: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              appLocalizations.createTime,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SpacingUnit.x4,
                color: colors.text,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              formatYMD(widget.note.dateTime.toString()),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SpacingUnit.x4,
                color: colors.text,
              ),
            ),
            const SizedBox(
              height: SpacingUnit.x4_5,
            ),
            Text(
              appLocalizations.note,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SpacingUnit.x4,
                color: colors.text,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.note.note,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SpacingUnit.x4,
                color: colors.text,
              ),
            ),
            const SizedBox(
              height: SpacingUnit.x4_5,
            ),
            Text(
              appLocalizations.destination,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
                fontWeight: FontWeight.w600,
              ),
            ),
            // SizedBox(
            //   height: SpacingUnit.x60,
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            //     child: ClipRRect(
            //       borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x2)),
            //       child: GoogleMap(
            //         gestureRecognizers: {
            //           Factory<PanGestureRecognizer>(() => PanGestureRecognizer())
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SpacingUnit.x2),
                        child: AppButton(
                          color: colors.blue,
                          colorText: colors.background,
                          onSubmit: () =>
                              nextUpdateNotesPage(context, widget.note),
                          title: appLocalizations.update,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SpacingUnit.x2),
                        child: AppButton(
                          color: colors.error,
                          colorBorder: colors.error,
                          onSubmit: () =>
                              logDeleteNoteDialog(context, widget.note),
                          title: appLocalizations.delete,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

logDeleteNoteDialog(BuildContext context, Note note) {
  final appLocalizations = AppLocalizations.of(context)!;
  updateNoteDialog(
    context: context,
    callBack: () => deleteNoteEvent(context, note),
    title: appLocalizations.doYouWantToDeleteTheNote,
  );
}

nextUpdateNotesPage(BuildContext context, Note note) {
  dI<AppNavigation>()
      .pushName(context, page: Pages.createNoteWidget, extra: {'note': note});
}

closePopUp(BuildContext context) {
  Navigator.of(context).pop();
}

deleteNoteEvent(BuildContext context, Note note) {
  dI<NoteSystemCubit>().deleteNotesEvent(id: note.id);
  Navigator.of(context).pop();
}

deleteAccountDialog(BuildContext context, VoidCallback callback,
    VoidCallback callbackThen) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: SizedBox(
          height: SpacingUnit.x27,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.doYouWantToDeleteYourAccount,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: SpacingUnit.x4,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: SpacingUnit.x4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SpacingUnit.x4),
                        child: AppButton(
                          color: Colors.blue,
                          colorBorder: Colors.blue,
                          colorText: Colors.white,
                          title: appLocalizations.ok,
                          onSubmit: () => deleteAccountEvent(context),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: SpacingUnit.x4),
                        child: AppButton(
                          colorText: Colors.blue,
                          color: Colors.white,
                          colorBorder: Colors.blue,
                          title: appLocalizations.cancel,
                          onSubmit: () {
                            callback.call();
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  ).then((value) => callbackThen.call());
}

deleteAccountEvent(BuildContext context) {
  dI<UserBloc>().add(const DeleteAccountEvent());
  Navigator.of(context).pop();
}
