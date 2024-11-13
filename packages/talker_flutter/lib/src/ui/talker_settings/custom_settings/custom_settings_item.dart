import 'package:flutter/material.dart';

abstract class CustomSettingsItem<T> {
  final String name;
  final T value;

  const CustomSettingsItem({
    required this.name,
    required this.value,
  });

  Widget widgetBuilder(BuildContext context, T value, bool isEnabled);
}
