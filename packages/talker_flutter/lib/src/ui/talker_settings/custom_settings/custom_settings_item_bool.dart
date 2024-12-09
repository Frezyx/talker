import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/talker_settings/talker_settings.dart';

class CustomSettingsItemBool extends CustomSettingsItem<bool> {
  final Function(bool value) onChanged;

  const CustomSettingsItemBool({
    required String name,
    required bool value,
    required this.onChanged,
  }) : super(name: name, value: value);

  @override
  Widget widgetBuilder(
    BuildContext context,
    bool value,
    bool isEnabled,
  ) {
    return CupertinoSwitch(
      value: value,
      trackColor: isEnabled ? Colors.red : Colors.grey,
      onChanged: isEnabled ? onChanged : null,
    );
  }
}
