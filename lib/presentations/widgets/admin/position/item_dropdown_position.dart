import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/position/position_bloc.dart';
import 'package:base_app/presentations/bloc/position/position_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDropdownPosition extends StatefulWidget {
  const ItemDropdownPosition({super.key, required this.onChange});

  final ValueChanged<String> onChange;

  @override
  State<ItemDropdownPosition> createState() => _ItemDropdownPositionState();
}

class _ItemDropdownPositionState extends State<ItemDropdownPosition> {

  String positionName = '';

  _listenerPosition(BuildContext context, PositionState state) {
    positionName = state.positions.map((e) => e.name).toList().first;
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<PositionBloc, PositionState>(
      listener: (context, state) => _listenerPosition(context, state),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(SpacingUnit.x2),
          child: DropdownMenu<String>(
            width: width * 0.6,
            initialSelection: positionName,
            onSelected: (String? value) => _select(value),
            dropdownMenuEntries: state.positions
                .map((e) => e.name)
                .toList()
                .map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        );
      },
    );
  }

  _select(String? value){
    setState(() {
      positionName = value!;
      widget.onChange.call(positionName);
    });
  }
}
