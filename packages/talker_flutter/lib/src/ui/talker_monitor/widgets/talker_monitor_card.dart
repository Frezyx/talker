import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/talker_base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerMonitorCard extends StatelessWidget {
  const TalkerMonitorCard({
    Key? key,
    required this.logs,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    required this.color,
    required this.icon,
    this.onTap,
    required this.theme,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final Widget? subtitleWidget;
  final List<TalkerData> logs;
  final Color color;
  final IconData icon;
  final VoidCallback? onTap;
  final TalkerScreenTheme theme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TalkerBaseCard(
        color: color,
        backgroundColor: theme.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: color,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: theme.textColor,
                              fontSize: 14,
                            ),
                          ),
                        if (subtitleWidget != null) subtitleWidget!
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.arrow_forward_ios_rounded, color: color),
          ],
        ),
      ),
    );
  }
}
