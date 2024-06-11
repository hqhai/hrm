import 'dart:io';

import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_button.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_load_flie.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_follower.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/postal_delivery/item_create_postal_delivery_type.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestPostalDeliveryPageRoute = GoRoute(
  path: Pages.createRequestPostalDeliveryPage,
  name: Pages.createRequestPostalDeliveryPage,
  builder: (context, GoRouterState state) => const CreateRequisitionPostalDeliveryPage(),
);

class CreateRequisitionPostalDeliveryPage extends StatefulWidget {
  const CreateRequisitionPostalDeliveryPage({super.key});

  @override
  State<CreateRequisitionPostalDeliveryPage> createState() =>
      _CreateRequisitionPostalDeliveryPageState();
}

class _CreateRequisitionPostalDeliveryPageState extends State<CreateRequisitionPostalDeliveryPage> {
  final TextEditingController reasonController = TextEditingController();
  String reason = '';
  List<User> followers = [];
  List<File> files = [];
  RequisitionDeliveryTypeEnum? transferType = RequisitionDeliveryTypeEnum.rush;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          RequisitionTypeEnum.postalDelivery.configTypeName,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(SpacingUnit.x3),
          margin: const EdgeInsets.all(SpacingUnit.x3),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
            border: Border.all(
              width: 1,
              color: colors.surface,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemCreateReasonTransferType(onChange: (value) => _setTransferType(value)),
              if (transferType == RequisitionDeliveryTypeEnum.rush)
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x3),
                  child: Text(appLocalizations.notePostalDelivery,
                      style: TextStyle(color: colors.error, fontSize: SpacingUnit.x3)),
                ),
              ItemCreateInputArea(
                textController: reasonController,
                title: appLocalizations.sendingPurpose,
                onChange: (value) => _setReason(value),
              ),
              ItemCreateFollower(
                  title: appLocalizations.follower, onChange: (value) => _setFollower(value)),
              ItemLoadFile(onChangeFiles: (value) => _setFile(value)),
              ItemButton(
                callbackSave: () => _save(),
                callbackCancel: () => _cancel(),
              )
            ],
          ),
        ),
      ),
    );
  }

  _setFollower(List<User> value) {
    setState(() {
      followers = value;
    });
  }

  _setReason(String value) {
    setState(() {
      reason = value;
    });
  }

  _setFile(List<File> value) {
    setState(() {
      files = value;
    });
  }

  _save() {}

  _cancel() {}

  _setTransferType(RequisitionDeliveryTypeEnum value) {
    setState(() {
      transferType = value;
    });
  }
}
