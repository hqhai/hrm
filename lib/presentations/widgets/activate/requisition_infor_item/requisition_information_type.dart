import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_business_trip.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_explanation.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_postal_delivery_service.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/requisition_information_content_type_vehicle_dispatch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequisitionInformationType extends StatelessWidget {
  const RequisitionInformationType({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        if (state.requisition.type == RequisitionTypeEnum.business) {
          return RequisitionInformationContentTypeBusinessTrip(
            requisitionBusinessTrip: state.requisition.content,
          );
        } else if (state.requisition.type == RequisitionTypeEnum.vehicleDispatch) {
          return RequisitionInformationContentTypeVehicleDispatch(
            requisitionVehicleDispatch: state.requisition.content,
          );
        } else if (state.requisition.type == RequisitionTypeEnum.postalDelivery) {
          return RequisitionInformationContentTypePostalDeliveryService(
            requisitionPostalDeliveryService: state.requisition.content,
          );
        } else if (state.requisition.type == RequisitionTypeEnum.explanation) {
          return RequisitionInformationContentTypeExplanation(
            requisitionExplanation: state.requisition.content,
          );
        } else {
          return Container();
        }
      },
    );
  }
}
