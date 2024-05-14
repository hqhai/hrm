// ignore_for_file: use_build_context_synchronously

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/domain/entities/request.dart';
import 'package:base_app/presentations/bloc/request/request/request_bloc.dart';
import 'package:base_app/presentations/bloc/request/request/request_event.dart';
import 'package:base_app/presentations/bloc/request/request/request_state.dart';
import 'package:base_app/presentations/widgets/custom/shimmer_load.dart';
import 'package:base_app/presentations/widgets/erro_or_data_not_exist/data_not_exist.dart';
import 'package:base_app/presentations/widgets/request/item/item_request.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoingRequest extends StatefulWidget {
  const DoingRequest({
    super.key,
  });

  @override
  State<DoingRequest> createState() => _DoingRequestState();
}

class _DoingRequestState extends State<DoingRequest> {
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  late ScrollController controller;
  RequestStatus status = RequestStatus.init;
  List<Request> requests = [];

  @override
  void initState() {
    dI<RequestBloc>().add(GetRequestEvent(
        status: StatusRequestStatus.doing.name, page: pageIndex, requests: const []));
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  void _scrollListener() {
    if (lengthList <= totalItems &&
        status == RequestStatus.getRequestSuccess &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<RequestBloc>().add(GetRequestEvent(
          status: StatusRequestStatus.doing.name, page: pageIndex, requests: requests));
    }
  }

  _listener(RequestState state) {
    if (state.status == RequestStatus.updateRequestSuccess) {
      dI<RequestBloc>().add(GetRequestEvent(
          status: StatusRequestStatus.doing.name, page: pageIndex, requests: const []));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<RequestBloc, RequestState>(
        listener: (context, state) {
          _listener(state);
        },
        builder: (context, state) {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              color: CustomsColor.colorBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: _checkStatus(state)
                ? checkData(state)
                    ? ListView.builder(
                        itemCount: state.requests.length,
                        controller: controller,
                        itemBuilder: (context, index) {
                          return ItemRequest(
                            index: index,
                          );
                        })
                    : const DataNotExist()
                : const ShimmerLoad(),
          );
        },
      ),
    );
  }

  bool _checkStatus(RequestState state) {
    return state.status != RequestStatus.getRequestError ||
        state.status != RequestStatus.getRequestInit;
  }

  bool checkData(RequestState state) {
    return state.requests.isNotEmpty && _checkStatus(state);
  }
}
