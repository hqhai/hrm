import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/time_keeping/icon_value.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemTimeKeepingGPS extends StatefulWidget {
  const ItemTimeKeepingGPS({
    super.key,
  });

  @override
  State<ItemTimeKeepingGPS> createState() => _ItemTimeKeepingGPSState();
}

class _ItemTimeKeepingGPSState extends State<ItemTimeKeepingGPS> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                height: width * 0.2,
                width: width * 0.2,
                Assets.images.icon.home.phFingerprintFill,
                colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
              ),
            ),
            IconValueWidget(
              icon: Assets.images.icon.home.mingcuteTimeLine,
              value: formatHMS(
                state.scheduleSchool.startTime.toString(),
              ),
            ),
            IconValueWidget(
              icon: Assets.images.icon.home.mingcuteTimeLine,
              value: formatHMS(
                state.scheduleSchool.endTime.toString(),
              ),
            ),
            IconValueWidget(
              icon: Assets.images.icon.home.icBaselinePlace,
              value: state.scheduleSchool.school?.address ?? "",
            ),
          ],
        );
      },
    );
  }
}
