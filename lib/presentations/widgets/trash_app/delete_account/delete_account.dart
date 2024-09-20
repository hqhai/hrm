import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_system_cubit.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:flutter/material.dart';

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
    return Container();
  }

  void logoutFunction() {
    setState(() {
      dI<AuthBloc>().add(const LogoutEvent());
      dI<UserBloc>().add(const ResetUserEvent());
      dI<NoteSystemCubit>().resetNotesEvent();
    });
  }
}
