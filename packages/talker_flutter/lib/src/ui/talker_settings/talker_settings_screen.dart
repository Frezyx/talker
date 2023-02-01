import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/src/ui/widgets/cards/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsBottomSheet extends StatelessWidget {
  const TalkerSettingsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.talker,
    this.additionalSettings,
    this.onUpdated,
  }) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final TalkerInterface talker;

  final List<AdditionalTalkerSetting>? additionalSettings;

  final VoidCallback? onUpdated;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Talker Settings',
      talkerScreenTheme: talkerScreenTheme,
      child: Expanded(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: _TalkerSettingsCard(
                talkerScreenTheme: talkerScreenTheme,
                title: 'Enabled',
                enabled: talker.settings.enabled,
                onChanged: (enabled) {
                  (enabled ? talker.enable : talker.disable).call();
                  onUpdated?.call();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: _TalkerSettingsCard(
                canEdit: talker.settings.enabled,
                talkerScreenTheme: talkerScreenTheme,
                title: 'Use console logs',
                enabled: talker.settings.useConsoleLogs,
                onChanged: (enabled) {
                  talker.configure(
                    settings: talker.settings.copyWith(
                      useConsoleLogs: enabled,
                    ),
                  );
                  onUpdated?.call();
                },
              ),
            ),
            SliverToBoxAdapter(
              child: _TalkerSettingsCard(
                canEdit: talker.settings.enabled,
                talkerScreenTheme: talkerScreenTheme,
                title: 'Use history',
                enabled: talker.settings.useHistory,
                onChanged: (enabled) {
                  talker.configure(
                    settings: talker.settings.copyWith(
                      useHistory: enabled,
                    ),
                  );
                  onUpdated?.call();
                },
              ),
            ),
            if (additionalSettings != null)
              ...additionalSettings!
                  .map(
                    (e) => SliverToBoxAdapter(
                      child: _TalkerSettingsCard(
                        talkerScreenTheme: talkerScreenTheme,
                        title: e.title,
                        enabled: e.value,
                        onChanged: (v) {
                          e.onChanged(v);
                          onUpdated?.call();
                        },
                      ),
                    ),
                  )
                  .toList(),
          ],
        ),
      ),
    );
  }
}

class _TalkerSettingsCard extends StatelessWidget {
  const _TalkerSettingsCard({
    Key? key,
    required this.talkerScreenTheme,
    required this.title,
    required this.enabled,
    required this.onChanged,
    this.canEdit = true,
  }) : super(key: key);

  final String title;
  final bool enabled;
  final Function(bool enabled) onChanged;
  final TalkerScreenTheme talkerScreenTheme;
  final bool canEdit;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: canEdit ? 1 : 0.7,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TalkerBaseCard(
          color: cardBackgroundColor,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                color: talkerScreenTheme.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: CupertinoSwitch(
              value: enabled,
              trackColor: canEdit ? Colors.red : Colors.grey,
              onChanged: canEdit ? onChanged : null,
            ),
          ),
        ),
      ),
    );
  }
}
