// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/src/ui/talker_settings/widgets/talker_setting_card.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/src/ui/widgets/cards/base_card.dart';
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
  TalkerDioLogger? _dioLogger;

  @override
  void initState() {
    final addons = widget.talker.value.addons;
    final dioAddon = addons[TalkerOriginalAddons.talkerDioLogger.code];
    if (dioAddon != null && dioAddon is TalkerDioLogger) {
      _dioLogger = dioAddon;
    }

    widget.talker.addListener(() {
      setState(() {});
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Text(
          'Dio logger settings',
          style: theme.textTheme.titleLarge?.copyWith(
            color: widget.talkerScreenTheme.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      if (_dioLogger != null) ...[
        TalkerSettingsCard(
          talkerScreenTheme: widget.talkerScreenTheme,
          title: 'Print request data',
          enabled: _dioLogger!.settings.printRequestData,
          onChanged: (enabled) {
            _dioLogger!.configure(printRequestData: enabled);
            widget.talker.notifyListeners();
          },
        ),
        TalkerSettingsCard(
          talkerScreenTheme: widget.talkerScreenTheme,
          title: 'Print response data',
          enabled: _dioLogger!.settings.printResponseData,
          onChanged: (enabled) {
            _dioLogger!.configure(printResponseData: enabled);
            widget.talker.notifyListeners();
          },
        ),
        TalkerSettingsCard(
          talkerScreenTheme: widget.talkerScreenTheme,
          title: 'Print request headers',
          enabled: _dioLogger!.settings.printRequestHeaders,
          onChanged: (enabled) {
            _dioLogger!.configure(printRequestHeaders: enabled);
            widget.talker.notifyListeners();
          },
        ),
        TalkerSettingsCard(
          talkerScreenTheme: widget.talkerScreenTheme,
          title: 'Print response headers',
          enabled: _dioLogger!.settings.printResponseHeaders,
          onChanged: (enabled) {
            _dioLogger!.configure(printResponseHeaders: enabled);
            widget.talker.notifyListeners();
          },
        ),
        TalkerSettingsCard(
          talkerScreenTheme: widget.talkerScreenTheme,
          title: 'Print response message',
          enabled: _dioLogger!.settings.printResponseMessage,
          onChanged: (enabled) {
            _dioLogger!.configure(printResponseMessage: enabled);
            widget.talker.notifyListeners();
          },
        ),
      ] else
        _TalkerDioLoggerNotSetup(talkerScreenTheme: widget.talkerScreenTheme),
    ];

    return BaseBottomSheet(
      title: 'Talker Settings',
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

class _TalkerDioLoggerNotSetup extends StatelessWidget {
  const _TalkerDioLoggerNotSetup({
    Key? key,
    required this.talkerScreenTheme,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TalkerBaseCard(
      color: cardBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
      child: Column(
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: talkerScreenTheme.iconsColor,
            size: 46,
          ),
          const SizedBox(height: 16),
          RichText(
            text: TextSpan(
              text:
                  'Init TalkerDioLogger() interceptor in your app to see dio logger settings',
              style: theme.textTheme.titleMedium?.copyWith(
                color: talkerScreenTheme.textColor,
                fontWeight: FontWeight.bold,
              ),
              children: const [
                TextSpan(text: '\n'),
                TextSpan(text: '\n'),
                TextSpan(
                  text: 'The settings will be available automatically',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
