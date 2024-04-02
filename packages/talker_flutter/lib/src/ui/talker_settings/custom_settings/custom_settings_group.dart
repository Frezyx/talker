import 'package:talker_flutter/src/ui/talker_settings/talker_settings.dart';

class CustomSettingsGroup {
  final String name;
  final bool showEnabled;
  final bool isEnabled;
  final Function(bool isEnabled)? onChangedIsEnabled;
  final List<CustomSettingsItem> items;

  const CustomSettingsGroup({
    required this.name,
    this.showEnabled = true,
    this.isEnabled = true,
    this.onChangedIsEnabled,
    this.items = const [],
  });
}
