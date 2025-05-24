import 'package:talker_flutter/src/ui/talker_settings/talker_settings.dart';

class CustomSettingsGroup {
  CustomSettingsGroup({
    required this.title,
    this.enabled = true,
    Function(bool val)? onToggleEnabled,
    this.items = const [],
  }) : _onToggleEnabled = onToggleEnabled;

  late final Function(bool val)? _onToggleEnabled;
  final String title;
  bool enabled;
  final List<CustomSettingsItem> items;

  void onChanged(bool val) {
    _onToggleEnabled?.call(val);
    enabled = val;
  }
}
