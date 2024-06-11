import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';

pDFShowDialog(BuildContext context, List<String> paths) async {
  final appLocalizations = AppLocalizations.of(context)!;
  final width = MediaQuery.of(context).size.width;
  final height = MediaQuery.of(context).size.height;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: SizedBox(
            height: height * 0.8,
            width: width * 0.8,
            child: ListView.builder(
              itemCount: paths.length,
              itemBuilder: (context, index) => Image.network(
                paths[index],
                height: height * 0.8,
                width: width * 0.8,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  Assets.images.signIn.background.path,
                  height: height * 0.8,
                  width: width * 0.8,
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => popDialog(context),
            child: Text(appLocalizations.ok),
          ),
        ],
      );
    },
  );
}
