import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTTab extends StatelessWidget {
  const OTTab({super.key});

  @override
  Widget build(BuildContext context) {
    //final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return const Column(
          children: [

          ],
        );
      },
    );
  }
}
