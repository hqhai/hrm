import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:flutter/material.dart';

saveRequest({
  List<File> files = const [],
  required BuildContext context,
  required bool checkCreate,
  required bool checkEdit,
  required VoidCallback checkLoadTrue,
  required VoidCallback completerSuccess,
  required VoidCallback completerFail,
  required PostRequestRequest postRequestRequest,
}) async {
  if (checkCreate) {
    checkLoadTrue.call();
    final Completer completer = Completer<bool>();
    dI<RequisitionBloc>().add(
      PostRequestEvent(
        files: files,
        completer: completer,
        postRequestRequest: postRequestRequest,
      ),
    );
    final status = await completer.future;
    if (status == true) {
      completerSuccess.call();
    }
    if (status == false) {
      completerFail.call();
    }
  } else if (checkEdit) {
    checkLoadTrue.call();
    final Completer completer = Completer<bool>();
    dI<RequisitionBloc>().add(
      EditRequestEvent(
        files: files,
        completer: completer,
        postRequestRequest: postRequestRequest,
      ),
    );
    final status = await completer.future;
    if (status == true) {
      completerSuccess.call();
    }
    if (status == false) {
      completerFail.call();
    }
  }
}
