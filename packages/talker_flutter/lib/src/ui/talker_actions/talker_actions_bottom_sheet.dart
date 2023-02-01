import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerActionsBottomSheet extends StatelessWidget {
  const TalkerActionsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.actions,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;
  final List<TalkerActionItem> actions;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Talker Actions',
      talkerScreenTheme: talkerScreenTheme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...actions
              .map(
                (e) => _ActionTile(
                  talkerScreenTheme: talkerScreenTheme,
                  action: e,
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    Key? key,
    required this.action,
    required this.talkerScreenTheme,
  }) : super(key: key);

  final TalkerActionItem action;
  final TalkerScreenTheme talkerScreenTheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        action.onTap();
      },
      title: Text(
        action.title,
        style: TextStyle(
          color: talkerScreenTheme.textColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: Icon(
        action.icon,
        color: talkerScreenTheme.iconsColor,
      ),
    );
  }
}

class TalkerActionItem {
  const TalkerActionItem({
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
}
