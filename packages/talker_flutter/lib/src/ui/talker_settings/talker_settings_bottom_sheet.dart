// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/talker_settings/widgets/talker_setting_card.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsBottomSheet extends StatefulWidget {
  const TalkerSettingsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.talker,
  }) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final ValueNotifier<TalkerInterface> talker;

  @override
  State<TalkerSettingsBottomSheet> createState() =>
      _TalkerSettingsBottomSheetState();
}

class _TalkerSettingsBottomSheetState extends State<TalkerSettingsBottomSheet> {
  @override
  void initState() {
    widget.talker.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settings = [
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
    ];

    return BaseBottomSheet(
      title: 'Talker Settings',
      talkerScreenTheme: widget.talkerScreenTheme,
      child: Expanded(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ...settings.map((e) => SliverToBoxAdapter(child: e)),

            // if (additionalSettings != null)
            //   ...additionalSettings!
            //       .map(
            //         (e) => SliverToBoxAdapter(
            //           child: TalkerSettingsCard(
            //             talkerScreenTheme: talkerScreenTheme,
            //             title: e.title,
            //             enabled: e.value,
            //             onChanged: (v) {
            //               e.onChanged(v);
            //             },
            //           ),
            //         ),
            //       )
            //       .toList(),
          ],
        ),
      ),
    );
  }
}
