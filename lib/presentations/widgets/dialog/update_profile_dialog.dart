import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

updateProfileDialog(BuildContext context, VoidCallback callback) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: Scrollbar(
          child: SizedBox(
            height: 140,
            child: Column(
              children: [
                Text(
                  maxLines: 3,
                  appLocalizations.doYouWantToUpdateProfile,
                  style: const TextStyle(color: Colors.white, fontSize: SpacingUnit.x6),
                ),
                const SizedBox(
                  height: SpacingUnit.x4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        callback.call();
                      },
                      child: Text(appLocalizations.ok),
                    ),
                    ElevatedButton(
                      child: Text(appLocalizations.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
