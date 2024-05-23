import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class ItemHomeCheckInCheckOutWidget extends StatefulWidget {
  const ItemHomeCheckInCheckOutWidget({super.key});

  @override
  State<ItemHomeCheckInCheckOutWidget> createState() => _ItemHomeCheckInCheckOutWidgetState();
}

class _ItemHomeCheckInCheckOutWidgetState extends State<ItemHomeCheckInCheckOutWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: SpacingUnit.x4_5),
            Text(
              appLocalizations.checkInOut,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
            ),
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, stateAttendance) {
                return Container(
                  padding: const EdgeInsets.all(SpacingUnit.x3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SpacingUnit.x2),
                    color: CustomsColor.colorBackground,
                    border: Border.all(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(SpacingUnit.x0_5),
                              child: Text(
                                "${appLocalizations.formOfTimekeeping} : ",
                                style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3,
                                    fontWeight: FontWeight.w900),
                              )),
                          Text(
                            'Vân tay',
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(SpacingUnit.x0_5),
                              child: Text(
                                "${appLocalizations.timeWorking} : ",
                                style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3,
                                    fontWeight: FontWeight.w900),
                              )),
                          Text(
                            'hành chính',
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(SpacingUnit.x0_5),
                              child: Text(
                                "${appLocalizations.date} : ",
                                style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3,
                                    fontWeight: FontWeight.w900),
                              )),
                          Text(
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(SpacingUnit.x0_5),
                                child: Text(
                                  appLocalizations.checkIn,
                                  style: TextStyle(
                                      color: colors.text,
                                      fontSize: SpacingUnit.x3,
                                      fontWeight: FontWeight.w900),
                                )),
                          ),
                          Expanded(
                            child: Padding(
                                padding: const EdgeInsets.all(SpacingUnit.x0_5),
                                child: Text(
                                  appLocalizations.checkOut,
                                  style: TextStyle(
                                      color: colors.text,
                                      fontSize: SpacingUnit.x3,
                                      fontWeight: FontWeight.w900),
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                top: SpacingUnit.x4_5,
                                right: SpacingUnit.x4_5,
                                bottom: SpacingUnit.x4_5,
                              ),
                              padding: const EdgeInsets.all(SpacingUnit.x4_5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(SpacingUnit.x0_25),
                                color: CustomsColor.colorBackground,
                                border: Border.all(
                                  color: colors.text,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                stateAttendance.attendance.checkIn ?? '------',
                                style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                  top: SpacingUnit.x4_5,
                                  right: SpacingUnit.x4_5,
                                  bottom: SpacingUnit.x4_5),
                              padding: const EdgeInsets.all(SpacingUnit.x4_5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(SpacingUnit.x0_25),
                                color: CustomsColor.colorBackground,
                                border: Border.all(
                                  color: colors.text,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                stateAttendance.attendance.checkOut ?? '------',
                                style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
