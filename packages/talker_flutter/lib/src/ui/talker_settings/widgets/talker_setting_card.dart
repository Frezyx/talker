import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/src/ui/widgets/cards/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsCard extends StatelessWidget {
  const TalkerSettingsCard({
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
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8)
              .copyWith(right: 0),
          color: cardBackgroundColor,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(
                color: talkerScreenTheme.textColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
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
