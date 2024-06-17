import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/trash_app/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class DeleteAccountWidget extends StatefulWidget {
  const DeleteAccountWidget({
    super.key,
  });

  @override
  State<DeleteAccountWidget> createState() => _DeleteAccountWidgetState();
}

class _DeleteAccountWidgetState extends State<DeleteAccountWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool checkListenWhen(UserStatus status, UserStatus status2) {
    return status != status2;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => checkListenWhen(
        previous.status,
        current.status,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: CustomsColor.colorBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(SpacingUnit.x4),
          ),
        ),
        child: Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: colors.blue),
            onPressed: () => _deleteAccount(context),
            child: Text(appLocalizations.deleteAccount,
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
          ),
        ),
      ),
    );
  }

  void logoutFunction() {
    setState(() {
      dI<AuthBloc>().add(const LogoutEvent());
      dI<UserBloc>().add(const ResetUserEvent());
      dI<NotesBloc>().add(const ResetNoteEvent());
    });
  }

  _deleteAccount(BuildContext context) {
    deleteAccountDialog(context);
  }

  _listener(BuildContext context, UserState state) {
    if (state.status == UserStatus.fail) {
      logoutFunction();
    }
  }
}
