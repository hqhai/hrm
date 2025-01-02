import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DataNotExist extends StatelessWidget {
  const DataNotExist({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: SpacingUnit.x5),
          Text(
            appLocalizations.errNotData,
            style: const TextStyle(
              color: Color(0xFF808890),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: SpacingUnit.x2,
          ),
          Image.asset(
            Assets.images.error.noData.path,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width - 200,
          )
        ],
      ),
    );
  }
}
