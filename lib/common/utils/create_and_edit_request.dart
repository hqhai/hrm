import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:flutter/material.dart';

saveRequest(
    {required BuildContext context,
    required bool checkCreate,
    required bool checkEdit,
    required VoidCallback checkLoadTrue,
    required VoidCallback completerSuccess,
    required VoidCallback completerFail,
    required PostRequestRequest postRequestRequest,}) async {
  if (checkCreate) {
    checkLoadTrue.call();
    final Completer completer = Completer<RequisitionEnum>();
    dI<RequisitionBloc>().add(
      PostRequestEvent(
        completer: completer,
        postRequestRequest: postRequestRequest,
      ),
    );
    final status = await completer.future;
    if (status == RequisitionEnum.success) {
          completerSuccess.call();
    }
    if (status == RequisitionEnum.fail) {
          completerFail.call();
    }
  } else if (checkEdit) {
        checkLoadTrue.call();
    final Completer completer = Completer<RequisitionEnum>();
    dI<RequisitionBloc>().add(
      EditRequestEvent(
        completer: completer,
        postRequestRequest: postRequestRequest,
      ),
    );
    final status = await completer.future;
    if (status == RequisitionEnum.success) {
          completerSuccess.call();
    }
    if (status == RequisitionEnum.fail) {
          completerFail.call();
    }
  }
}
