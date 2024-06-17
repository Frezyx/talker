import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';

class TalkerActionsBottomSheet extends StatelessWidget {
  const TalkerActionsBottomSheet({
    Key? key,
    required this.actions,
  }) : super(key: key);

  final List<TalkerActionItem> actions;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Talker Actions',
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...actions
                .asMap()
                .entries
                .map(
                  (e) => _ActionTile(
                    action: e.value,
                    showDivider: e.key != actions.length - 1,
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    Key? key,
    required this.action,
    this.showDivider = true,
  }) : super(key: key);

  final TalkerActionItem action;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () => _onTap(context),
          title: Text(
            action.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          leading: Icon(
            action.icon,
          ),
        ),
        if (showDivider) Divider(height: 1),
      ],
    );
  }

  void _onTap(BuildContext context) {
    Navigator.pop(context);
    action.onTap();
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
