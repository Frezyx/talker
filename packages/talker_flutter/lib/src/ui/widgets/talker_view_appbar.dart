import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/src/ui/theme/default_theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerViewAppBar extends StatelessWidget {
  const TalkerViewAppBar({
    Key? key,
    this.title,
    required this.talker,
    required this.talkerTheme,
    required this.titilesController,
    required this.controller,
    required this.titles,
    required this.unicTitles,
    required this.onMonitorTap,
    required this.onSettingsTap,
    required this.onActionsTap,
    required this.onToggleTitle,
  }) : super(key: key);

  final String? title;

  final Talker talker;
  final TalkerScreenTheme talkerTheme;
  final GroupButtonController titilesController;
  final TalkerScreenController controller;

  final List<String> titles;
  final List<String> unicTitles;

  final VoidCallback onMonitorTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onActionsTap;

  final Function(String title, bool selected) onToggleTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      backgroundColor: talkerTheme.backgroundColor,
      elevation: 0,
      pinned: true,
      floating: true,
      expandedHeight: 180,
      collapsedHeight: 60,
      toolbarHeight: 60,
      actions: [
        UnconstrainedBox(
          child: _MonitorButton(
            talker: talker,
            onPressed: onMonitorTap,
          ),
        ),
        UnconstrainedBox(
          child: IconButton(
            onPressed: onSettingsTap,
            icon: const Icon(Icons.settings_rounded),
          ),
        ),
        UnconstrainedBox(
          child: IconButton(
            onPressed: onActionsTap,
            icon: const Icon(Icons.menu_rounded),
          ),
        ),
        const SizedBox(width: 10),
      ],
      title: title != null
          ? Text(title!, style: const TextStyle(color: Colors.white))
          : null,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    scrollDirection: Axis.horizontal,
                    children: [
                      GroupButton(
                        controller: titilesController,
                        isRadio: false,
                        buttonBuilder: (selected, value, context) {
                          final count = titles.where((e) => e == value).length;
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selected
                                  ? theme.primaryColor
                                  : cardBackgroundColor,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '$count',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$value',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        onSelected: (_, i, selected) =>
                            onToggleTitle(unicTitles[i], selected),
                        buttons: unicTitles,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                _SearchTextField(
                  controller: controller,
                  talkerScreenTheme: talkerTheme,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({
    Key? key,
    required this.talkerScreenTheme,
    required this.controller,
  }) : super(key: key);

  final TalkerScreenTheme talkerScreenTheme;
  final TalkerScreenController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        style: theme.textTheme.bodyLarge!.copyWith(
          color: talkerScreenTheme.textColor,
          fontSize: 14,
        ),
        onChanged: controller.updateFilterSearchQuery,
        decoration: InputDecoration(
          fillColor: theme.cardColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: talkerScreenTheme.textColor),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: talkerScreenTheme.textColor),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: talkerScreenTheme.textColor,
          ),
          hintText: 'Search...',
          hintStyle: theme.textTheme.bodyLarge!.copyWith(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _MonitorButton extends StatelessWidget {
  const _MonitorButton({
    Key? key,
    required this.talker,
    required this.onPressed,
  }) : super(key: key);

  final Talker talker;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TalkerBuilder(
      talker: talker,
      builder: (context, data) {
        final haveErrors = data
            .where((e) => e is TalkerError || e is TalkerException)
            .isNotEmpty;
        return Stack(
          children: [
            Center(
              child: IconButton(
                onPressed: onPressed,
                icon: const Icon(Icons.monitor_heart_outlined),
              ),
            ),
            if (haveErrors)
              Positioned(
                right: 6,
                top: 8,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  height: 7,
                  width: 7,
                ),
              ),
          ],
        );
      },
    );
  }
}
