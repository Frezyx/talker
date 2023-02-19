import 'package:flutter/material.dart';

class AdditionalTalkerSetting {
  const AdditionalTalkerSetting({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
}
