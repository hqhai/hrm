import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.color = Colors.black,
    this.checkColor = Colors.white,
  });

  final String label;
  final bool value;
  final Function onChanged;
  final Color color;
  final Color checkColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Row(
        children: <Widget>[
          Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: -13,
            children: [
              const SizedBox(),
              Checkbox(
                side: BorderSide(
                  color: color,
                ),
                checkColor: checkColor,
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue);
                },
              ),
            ],
          ),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}
