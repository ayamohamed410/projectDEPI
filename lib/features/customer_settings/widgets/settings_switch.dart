import 'package:final_depi/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsSwitch extends StatelessWidget {
  const SettingsSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: ColorsApp.whiteColor,
      activeTrackColor: const Color.fromARGB(255, 21, 40, 255),
    );
  }
}
