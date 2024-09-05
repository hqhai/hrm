import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

final shiftsPageReviewRoute = GoRoute(
    path: Pages.shiftsPageReview,
    name: Pages.shiftsPageReview,
    builder: (context, GoRouterState state) {
      if (state.uri.hasQuery) {
        final query = state.uri.queryParameters;
        final data = ShiftsReviewQueryParams.fromJson(query);
        return ShiftsPageReview(
          id: data.id,
        );
      }
      return const ErrorPage();
    });

class ShiftsPageReview extends StatefulWidget {
  final String id;

  const ShiftsPageReview({super.key, required this.id});
  @override
  State<ShiftsPageReview> createState() => _ShiftsPageReviewState();
}

class _ShiftsPageReviewState extends State<ShiftsPageReview> {
  final TextEditingController reasonController = TextEditingController();

  _onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return BlocBuilder<WorkDayBloc, WorkDayState>(
      builder: (context, state) {
        final data =
            state.items.singleWhere((element) => element.id == widget.id);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(SpacingUnit.x12),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SpacingUnit.x5,
                        right: SpacingUnit.x5,
                        bottom: SpacingUnit.x5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => _onBack(),
                            child: Icon(
                              Icons.clear,
                              color: colors.text,
                              size: SpacingUnit.x7,
                            ),
                          ),
                          const SizedBox(width: SpacingUnit.x4),
                          Text(
                            appLocalizations.shiftDetails,
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.all(SpacingUnit.x4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShiftsContentWidget(
                    data: data,
                  ),
                  // if (checkType(data?.status ?? WorkShiftRequestStatus.usable))
                  //   ShiftReasonWidget(reasonController: reasonController),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ShiftsContentWidget extends StatelessWidget {
  const _ShiftsContentWidget({required this.data});

  final WorkDayAdmin data;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final DateFormat formatter = DateFormat("hh:mm dd/MM/yyyy");
    final String formatted =
        formatter.format(data.createdDate ?? DateTime.now());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: SpacingUnit.x2),
          child: Text(
            '${nameWeekDay(data.workDate)}, ${dayMonthYear(
              time: data.workDate,
              context: context,
            )}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: SpacingUnit.x4,
              color: colors.text,
            ),
          ),
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.shiftCode,
          value: data.code,
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.shiftName,
          value: data.name,
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.workingTime1,
          value:
              '${strSeconds(data.startTime) ?? ''} - ${strSeconds(data.endTime) ?? ''}',
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.recordedNumberOfShifts,
          value: data.workEffort.toString(),
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.operationDay,
          value: formatted,
        ),
      ],
    );
  }
}

class _TitleValueLeave extends StatelessWidget {
  const _TitleValueLeave({
    required this.title,
    required this.value,
    this.size = SpacingUnit.x3,
    this.font = FontWeight.normal,
    this.padding = 0,
  });

  final String title, value;
  final double size, padding;
  final FontWeight font;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              color: colors.text,
              fontSize: size,
              fontWeight: font,
            ),
          ),
          const SizedBox(width: SpacingUnit.x2),
          Text(
            value,
            style: TextStyle(
              color: colors.text,
              fontSize: size,
            ),
          ),
        ],
      ),
    );
  }
}
