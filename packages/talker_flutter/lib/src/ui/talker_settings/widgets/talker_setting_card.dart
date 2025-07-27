import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsCard extends StatelessWidget {
  const TalkerSettingsCard({
    Key? key,
    required this.talkerScreenTheme,
    required this.title,
    this.enabled = false,
    this.onChanged,
    this.canEdit = true,
    this.trailing,
  }) : super(key: key);

  final String title;
  final bool enabled;
  final Function(bool enabled)? onChanged;
  final TalkerScreenTheme talkerScreenTheme;
  final bool canEdit;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: canEdit ? 1 : 0.7,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: TalkerBaseCard(
          padding: const EdgeInsets.only(left: 8),
          color: talkerScreenTheme.textColor,
          backgroundColor: talkerScreenTheme.cardColor,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
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
              inactiveTrackColor: canEdit ? Colors.red : Colors.grey,
              onChanged: canEdit ? onChanged : null,
            ),
          ),
        ),
      ),
    );
  }
}
