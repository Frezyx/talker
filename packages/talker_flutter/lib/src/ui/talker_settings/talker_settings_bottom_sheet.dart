// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/talker_settings/widgets/talker_setting_card.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsBottomSheet extends StatefulWidget {
  const TalkerSettingsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.talker,
    required this.customSettings,
  }) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final ValueNotifier<Talker> talker;

  /// Custom settings
  final List<CustomSettingsGroup> customSettings;

  @override
  State<TalkerSettingsBottomSheet> createState() =>
      _TalkerSettingsBottomSheetState();
}

class _TalkerSettingsBottomSheetState extends State<TalkerSettingsBottomSheet> {
  late final listenableCustomSettings = ValueNotifier(widget.customSettings);

  @override
  void initState() {
    widget.talker.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final talker = widget.talker.value;
    final theme = Theme.of(context);
    final settings = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          context.l10n.talkerSettings,
          style: theme.textTheme.titleLarge?.copyWith(
            color: widget.talkerScreenTheme.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      TalkerSettingsCard(
        talkerScreenTheme: widget.talkerScreenTheme,
        title: context.l10n.enabled,
        enabled: talker.settings.enabled,
        onChanged: (enabled) {
          (enabled ? talker.enable : talker.disable).call();
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: talker.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: context.l10n.useConsoleLogs,
        enabled: talker.settings.useConsoleLogs,
        onChanged: (enabled) {
          talker.configure(
            settings: talker.settings.copyWith(
              useConsoleLogs: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      TalkerSettingsCard(
        canEdit: talker.settings.enabled,
        talkerScreenTheme: widget.talkerScreenTheme,
        title: context.l10n.useHistory,
        enabled: talker.settings.useHistory,
        onChanged: (enabled) {
          talker.configure(
            settings: talker.settings.copyWith(
              useHistory: enabled,
            ),
          );
          widget.talker.notifyListeners();
        },
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          context.l10n.packagesSettings,
          style: theme.textTheme.titleLarge?.copyWith(
            color: widget.talkerScreenTheme.textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      ...widget.talker.value.settings.registeredKeys
          .map(
            (key) => TalkerSettingsCard(
              talkerScreenTheme: widget.talkerScreenTheme,
              title: key,
              enabled: talker.filter.disabledKeys.isEmpty ||
                  !talker.filter.disabledKeys.contains(key),
              onChanged: (enabled) => _toggleKeySelected(enabled, key),
            ),
          )
          .toList(),
      ...listenableCustomSettings.value.map(
        (CustomSettingsGroup group) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Text(
                  group.title,
                  textAlign: TextAlign.start,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: widget.talkerScreenTheme.textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TalkerSettingsCard(
                talkerScreenTheme: widget.talkerScreenTheme,
                title: context.l10n.enabled,
                enabled: group.enabled,
                onChanged: (val) {
                  group.onChanged.call(val);
                  widget.talker.notifyListeners();
                },
              ),
              ...group.items.map(
                (CustomSettingsItem item) => TalkerSettingsCard(
                  canEdit: group.enabled,
                  enabled: item.value,
                  talkerScreenTheme: widget.talkerScreenTheme,
                  title: item.name,
                  onChanged: (val) {
                    item.onChanged(val);
                    widget.talker.notifyListeners();
                  },
                  trailing: item.widgetBuilder(
                    context,
                    item.value,
                    group.enabled,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //   child: Text(
      //     'Dio logger settings',
      //     style: theme.textTheme.titleLarge?.copyWith(
      //       color: widget.talkerScreenTheme.textColor,
      //       fontWeight: FontWeight.w700,
      //     ),
      //   ),
      // ),
      // if (_dioLogger != null) ...[
      //   TalkerSettingsCard(
      //     talkerScreenTheme: widget.talkerScreenTheme,
      //     title: 'Print request data',
      //     enabled: _dioLogger!.settings.printRequestData,
      //     onChanged: (enabled) {
      //       _dioLogger!.configure(printRequestData: enabled);
      //       widget.talker.notifyListeners();
      //     },
      //   ),
      //   TalkerSettingsCard(
      //     talkerScreenTheme: widget.talkerScreenTheme,
      //     title: 'Print response data',
      //     enabled: _dioLogger!.settings.printResponseData,
      //     onChanged: (enabled) {
      //       _dioLogger!.configure(printResponseData: enabled);
      //       widget.talker.notifyListeners();
      //     },
      //   ),
      //   TalkerSettingsCard(
      //     talkerScreenTheme: widget.talkerScreenTheme,
      //     title: 'Print request headers',
      //     enabled: _dioLogger!.settings.printRequestHeaders,
      //     onChanged: (enabled) {
      //       _dioLogger!.configure(printRequestHeaders: enabled);
      //       widget.talker.notifyListeners();
      //     },
      //   ),
      //   TalkerSettingsCard(
      //     talkerScreenTheme: widget.talkerScreenTheme,
      //     title: 'Print response headers',
      //     enabled: _dioLogger!.settings.printResponseHeaders,
      //     onChanged: (enabled) {
      //       _dioLogger!.configure(printResponseHeaders: enabled);
      //       widget.talker.notifyListeners();
      //     },
      //   ),
      //   TalkerSettingsCard(
      //     talkerScreenTheme: widget.talkerScreenTheme,
      //     title: 'Print response message',
      //     enabled: _dioLogger!.settings.printResponseMessage,
      //     onChanged: (enabled) {
      //       _dioLogger!.configure(printResponseMessage: enabled);
      //       widget.talker.notifyListeners();
      //     },
      //   ),
      // ] else
      //   _TalkerDioLoggerNotSetup(talkerScreenTheme: widget.talkerScreenTheme),
    ];

    return BaseBottomSheet(
      title: context.l10n.settings,
      talkerScreenTheme: widget.talkerScreenTheme,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          ...settings,
        ],
      ),
    );
  }

  void _toggleKeySelected(bool enabled, String e) {
    final talker = widget.talker.value;
    final keys = talker.filter.disabledKeys.toList();
    if (!enabled) {
      keys.add(e);
    } else {
      keys.remove(e);
    }
    talker.configure(filter: talker.filter.copyWith(disabledKeys: keys));
    widget.talker.notifyListeners();
  }
}

// class _TalkerDioLoggerNotSetup extends StatelessWidget {
//   const _TalkerDioLoggerNotSetup({
//     Key? key,
//     required this.talkerScreenTheme,
//   }) : super(key: key);

//   final TalkerScreenTheme talkerScreenTheme;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return TalkerBaseCard(
//       color: cardBackgroundColor,
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
//       child: Column(
//         children: [
//           Icon(
//             Icons.info_outline_rounded,
//             color: talkerScreenTheme.iconsColor,
//             size: 46,
//           ),
//           const SizedBox(height: 16),
//           RichText(
//             text: TextSpan(
//               text:
//                   'Init TalkerDioLogger() interceptor in your app to see dio logger settings',
//               style: theme.textTheme.titleMedium?.copyWith(
//                 color: talkerScreenTheme.textColor,
//                 fontWeight: FontWeight.bold,
//               ),
//               children: const [
//                 TextSpan(text: '\n'),
//                 TextSpan(text: '\n'),
//                 TextSpan(
//                   text: 'The settings will be available automatically',
//                   style: TextStyle(fontWeight: FontWeight.w400),
//                 ),
//               ],
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }
