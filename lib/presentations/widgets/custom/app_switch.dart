import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class AppSwitch extends StatelessWidget {
  final bool check;
  final ValueChanged<bool> onChange;

  const AppSwitch({super.key, required this.check, required this.onChange});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Switch(
      value: check,
      activeTrackColor: colors.blue,
      activeColor: colors.background,
      inactiveTrackColor: colors.secondaryContainer.withValues(alpha: 0.1),
      inactiveThumbColor: colors.secondaryContainer.withValues(alpha: 0.5),
      onChanged: (bool value) => onChange.call(value),
    );
  }
}
