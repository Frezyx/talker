import 'package:flutter/material.dart';

import 'package:talker_flutter/talker_flutter.dart';

class ActionsBottomSheet extends StatelessWidget {
  const ActionsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.actions,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;
  final List<BottomSheetAction> actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: talkerScreenTheme.backgroudColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          ...actions
              .map((e) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        onTap: e.onTap,
                        title: Text(
                          e.title,
                          style: TextStyle(
                            color: talkerScreenTheme.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        leading:
                            Icon(e.icon, color: talkerScreenTheme.iconsColor),
                      ),
                    ],
                  ))
              .toList(),
        ],
      ),
    );
  }
}

class BottomSheetAction {
  const BottomSheetAction({
    required this.onTap,
    required this.title,
    required this.icon,
  });

  final VoidCallback onTap;
  final String title;
  final IconData icon;
}
