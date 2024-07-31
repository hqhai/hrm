import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_business_trip.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_explanation.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_late.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_leave.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_overtime.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_postal_delivery_service.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_stationeries.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_vehicle_dispatch.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_warehouse_releaseds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequisitionInformationType extends StatelessWidget {
  const RequisitionInformationType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, stateRequisition) {
        return BlocBuilder<FlowBloc, FlowState>(
          builder: (context, state) {
            return inFlowType(state.flow.flowType);
          },
        );
      },
    );
  }
}

Widget inFlowType(RequisitionTypeEnum? type) {
  switch (type) {
    case RequisitionTypeEnum.leaveFiveDaysOrMore:
      return const RequisitionInformationContentTypeLeave();
    case RequisitionTypeEnum.leaveTwoDayToFourDay:
      return const RequisitionInformationContentTypeLeave();
    case RequisitionTypeEnum.leaveHalfDayToOneDay:
      return const RequisitionInformationContentTypeLeave();
    case RequisitionTypeEnum.lateOrEarly:
      return const RequisitionInformationContentTypeLate();
    case RequisitionTypeEnum.overTime:
      return const RequisitionInformationContentTypeOverTime();
    case RequisitionTypeEnum.bussiness:
      return const RequisitionInformationContentTypeBusinessTrip();
    case RequisitionTypeEnum.vehicleDriver:
      return const RequisitionInformationContentTypeVehicleDispatch();
    case RequisitionTypeEnum.postalDelivery:
      return const RequisitionInformationContentTypePostalDeliveryService();
    case RequisitionTypeEnum.warehouseReleased:
      return const RequisitionInformationContentTypeWarehouseReleaseds();
    case RequisitionTypeEnum.stationery:
      return const RequisitionInformationContentTypeStationeries();
    case RequisitionTypeEnum.explanation:
      return const RequisitionInformationContentTypeExplanation();
    case null:
    case RequisitionTypeEnum.core:
      return Container();
  }
}
