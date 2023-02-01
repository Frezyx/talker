import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/src/ui/widgets/cards/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsScreen extends StatefulWidget {
  const TalkerSettingsScreen({
    Key? key,
    required this.talkerScreenTheme,
    required this.talker,
    this.additionalSettings,
  }) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final TalkerInterface talker;

  final List<AdditionalTalkerSetting> Function()? additionalSettings;

  @override
  State<TalkerSettingsScreen> createState() => _TalkerSettingsScreenState();
}

class _TalkerSettingsScreenState extends State<TalkerSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.talkerScreenTheme.backgroudColor,
      appBar: AppBar(
        title: const FittedBox(
          fit: BoxFit.scaleDown,
          child: Text('Talker Settings'),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: _TalkerSettingsCard(
              talkerScreenTheme: widget.talkerScreenTheme,
              title: 'Enabled',
              enabled: widget.talker.settings.enabled,
              onChanged: (enabled) {
                (enabled ? widget.talker.enable : widget.talker.disable).call();
                setState(() {});
              },
            ),
          ),
          SliverToBoxAdapter(
            child: _TalkerSettingsCard(
              canEdit: widget.talker.settings.enabled,
              talkerScreenTheme: widget.talkerScreenTheme,
              title: 'Use console logs',
              enabled: widget.talker.settings.useConsoleLogs,
              onChanged: (enabled) {
                widget.talker.configure(
                  settings: widget.talker.settings.copyWith(
                    useConsoleLogs: enabled,
                  ),
                );
                setState(() {});
              },
            ),
          ),
          SliverToBoxAdapter(
            child: _TalkerSettingsCard(
              canEdit: widget.talker.settings.enabled,
              talkerScreenTheme: widget.talkerScreenTheme,
              title: 'Use history',
              enabled: widget.talker.settings.useHistory,
              onChanged: (enabled) {
                widget.talker.configure(
                  settings: widget.talker.settings.copyWith(
                    useHistory: enabled,
                  ),
                );
                setState(() {});
              },
            ),
          ),
          if (widget.additionalSettings != null)
            ...widget.additionalSettings!
                .call()
                .map(
                  (e) => SliverToBoxAdapter(
                    child: _TalkerSettingsCard(
                      talkerScreenTheme: widget.talkerScreenTheme,
                      title: e.title,
                      enabled: e.value,
                      onChanged: e.onChanged,
                    ),
                  ),
                )
                .toList(),
        ],
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
