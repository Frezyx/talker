import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerViewAppBar extends StatelessWidget {
  const TalkerViewAppBar({
    Key? key,
    required this.title,
    required this.leading,
    required this.talker,
    required this.titlesController,
    required this.controller,
    required this.titles,
    required this.uniqTitles,
    required this.onMonitorTap,
    required this.onSettingsTap,
    required this.onActionsTap,
    required this.onToggleTitle,
  }) : super(key: key);

  final String? title;
  final Widget? leading;

  final Talker talker;
  final GroupButtonController titlesController;
  final TalkerViewController controller;

  final List<String?> titles;
  final List<String?> uniqTitles;

  final VoidCallback onMonitorTap;
  final VoidCallback onSettingsTap;
  final VoidCallback onActionsTap;

  final Function(String title, bool selected) onToggleTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      elevation: 0,
      pinned: true,
      floating: true,
      expandedHeight: 174,
      collapsedHeight: 60,
      toolbarHeight: 60,
      leading: leading,
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
            icon: const Icon(
              Icons.menu_rounded,
            ),
          ),
        ),
        const SizedBox(width: 10),
      ],
      title: title != null ? Text(title!) : null,
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
                        controller: titlesController,
                        isRadio: false,
                        buttonBuilder: (selected, value, context) {
                          final count = titles.where((e) => e == value).length;
                          return Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: theme.colorScheme.onSurface,
                              ),
                              borderRadius: BorderRadius.circular(10),
                              color: selected
                                  ? theme.colorScheme.primaryContainer
                                  : theme.colorScheme.surface,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '$count',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '$value',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                        onSelected: (_, i, selected) =>
                            _onToggle(uniqTitles[i], selected),
                        buttons: uniqTitles,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                _SearchTextField(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onToggle(String? title, bool selected) {
    if (title == null) return;
    onToggleTitle(title, selected);
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TalkerViewController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
        style: theme.textTheme.bodyLarge!.copyWith(
          fontSize: 14,
        ),
        onChanged: controller.updateFilterSearchQuery,
        decoration: InputDecoration(
          fillColor: theme.cardColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: theme.colorScheme.onSurface),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          prefixIcon: const Icon(Icons.search, size: 20),
          hintText: 'Search...',
          hintStyle: theme.textTheme.bodyLarge!.copyWith(
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
