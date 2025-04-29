import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/requisition/requisition/post_request_request.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:flutter/material.dart';

saveRequest({
  List<File> files = const [],
  required bool checkCreate,
  required bool checkEdit,
  required VoidCallback checkLoadTrue,
  required PostRequestRequest postRequestRequest,
}) async {
  if (checkCreate) {
    checkLoadTrue.call();
    dI<RequisitionBloc>().add(
      PostRequestEvent(
        files: files,
        postRequestRequest: postRequestRequest,
      ),
    );
  } else if (checkEdit) {
    checkLoadTrue.call();
    dI<RequisitionBloc>().add(
      EditRequestEvent(
        files: files,
        postRequestRequest: postRequestRequest,
      ),
    );
  }
}
