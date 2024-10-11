import 'package:flutter/material.dart';

import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_shop_app_example/utils/custom_settings.dart';
import 'package:talker_shop_app_example/utils/di.dart';

TalkerSettingsBottomSheetBase talkerCustomSettingsBottomSheetCreator({
  required ValueNotifier<Talker> talker,
  required TalkerScreenTheme talkerScreenTheme}) {

  return TalkerCustomSettingsBottomSheet(
    key: UniqueKey(),
    talkerScreenTheme: talkerScreenTheme,
    talker: talker,
  );
}

class TalkerCustomSettingsBottomSheet extends TalkerSettingsBottomSheetBase {
  const TalkerCustomSettingsBottomSheet({
    super.key,
    required super.talkerScreenTheme,
    required super.talker,
  }) : super();

  @override
  State<TalkerCustomSettingsBottomSheet> createState() =>
      _TalkerCustomSettingsBottomSheetState();
}

class _TalkerCustomSettingsBottomSheetState extends State<TalkerCustomSettingsBottomSheet> {

  @override
  void initState() {
    widget.talker.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Basic settings',
          style: theme.textTheme.titleLarge?.copyWith(
            color: widget.talkerScreenTheme.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      TalkerSettingsCard(
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Enabled',
        enabled: widget.talker.value.settings.enabled,
        onChanged: (enabled) {
          (enabled ? widget.talker.value.enable : widget.talker.value.disable)
              .call();
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: widget.talker.value.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Use console logs',
        enabled: widget.talker.value.settings.useConsoleLogs,
        onChanged: (enabled) {
          widget.talker.value.configure(
            settings: widget.talker.value.settings.copyWith(
              useConsoleLogs: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: widget.talker.value.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Use history',
        enabled: widget.talker.value.settings.useHistory,
        onChanged: (enabled) {
          widget.talker.value.configure(
            settings: widget.talker.value.settings.copyWith(
              useHistory: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: widget.talker.value.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Custom Bool',
        enabled: DI<CustomSettings>().someCustomBool &&
                 widget.talker.value.settings.enabled,
        onChanged: (enabled) {
          DI<CustomSettings>().someCustomBool = enabled;
          DI<Talker>().info("Custom Bool set to ${enabled ? 'TRUE' : 'FALSE'}");
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: true,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: 'Global Custom Bool',
        enabled: DI<CustomSettings>().anotherCustomBool,
        onChanged: (enabled) {
          DI<CustomSettings>().anotherCustomBool = enabled;
          DI<Talker>().info("Global Custom Bool set to ${enabled ? 'TRUE' : 'FALSE'}");
          widget.talker.notifyListeners();
        },
      ),
    ];

    return TalkerBaseBottomSheet(
      title: 'Talker Custom Settings',
      talkerScreenTheme: widget.talkerScreenTheme,
      child: Expanded(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ...settings.map((e) => SliverToBoxAdapter(child: e)),
          ],
        ),
      ),
    );
  }
}
