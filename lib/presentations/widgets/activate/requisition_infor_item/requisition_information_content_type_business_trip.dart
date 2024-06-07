import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_business_trip.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeBusinessTrip extends StatelessWidget {
  const RequisitionInformationContentTypeBusinessTrip(
      {super.key, this.requisitionBusinessTrip = const RequisitionBusinessTrip()});

  final RequisitionBusinessTrip requisitionBusinessTrip;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appLocalizations.contentOfApplication,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.startTime,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionBusinessTrip.startDate ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.endTime,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionBusinessTrip.endDate ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.totalDays,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text((requisitionBusinessTrip.totalTime ?? 0).toString(),
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.accompanyingPerson,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                if (requisitionBusinessTrip.substitutePersons?.isNotEmpty ?? false)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                    height: SpacingUnit.x6 * requisitionBusinessTrip.substitutePersons!.length,
                    child: ListView.builder(
                      itemCount: requisitionBusinessTrip.substitutePersons!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
                        child: Text(
                          requisitionBusinessTrip.substitutePersons![index],
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.vehicle,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionBusinessTrip.vehicle ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalizations.description,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3)),
                Text(requisitionBusinessTrip.content ?? "",
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3))
              ],
            ),
          ),
          Text(
            appLocalizations.workingContent,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
              fontWeight: FontWeight.w800,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: SpacingUnit.x1, top: SpacingUnit.x2),
            child: Text(
              requisitionBusinessTrip.content ?? "",
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
