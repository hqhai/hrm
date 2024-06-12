import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_business_trip.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_explanation.dart';
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
            if (state.flow.flowType == RequisitionTypeEnum.bussiness) {
              return const RequisitionInformationContentTypeBusinessTrip();
            } else if (state.flow.flowType == RequisitionTypeEnum.vehicleDriver) {
              return const RequisitionInformationContentTypeVehicleDispatch();
            } else if (state.flow.flowType == RequisitionTypeEnum.postalDelivery) {
              return const RequisitionInformationContentTypePostalDeliveryService();
            } else if (state.flow.flowType == RequisitionTypeEnum.explanation) {
              return const RequisitionInformationContentTypeExplanation();
            } else if (state.flow.flowType == RequisitionTypeEnum.warehouseReleased) {
              return const RequisitionInformationContentTypeWarehouseReleaseds();
            }else if (state.flow.flowType == RequisitionTypeEnum.stationery) {
              return const RequisitionInformationContentTypeStationeries();
            } else {
              return Container();
            }
          },
        );
      },
    );
  }
}
