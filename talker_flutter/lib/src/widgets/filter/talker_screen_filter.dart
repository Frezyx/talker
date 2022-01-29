import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenFilter extends StatelessWidget {
  const TalkerScreenFilter({
    Key? key,
    required this.controller,
    required this.options,
  }) : super(key: key);

  final TalkerScreenController controller;
  final TalkerScreenOptions options;

  @override
  Widget build(BuildContext context) {
    final titles = unicTitles.map((e) => e.toString()).toList();
    final types = unicTypes.map((e) => e).toList();
    final theme = Theme.of(context);
    return ListView(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: TextFormField(
            onChanged: controller.updateFilterSearchQuery,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Titles',
            style: theme.textTheme.headline6!.copyWith(
              color: options.textColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GroupButton.checkbox(
            buttons: titles,
            onSelected: (i, selected) {
              _onToggleTitle(titles[i], selected);
            },
            mainGroupAlignment: MainGroupAlignment.start,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'Types',
            style: theme.textTheme.headline6!.copyWith(
              color: options.textColor,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GroupButton.checkbox(
            buttons: types.map((e) => e.toString()).toList(),
            onSelected: (i, selected) {
              _onToggleType(types[i], selected);
            },
            mainGroupAlignment: MainGroupAlignment.start,
          ),
        ),
      ],
    );
  }

  void _onToggleType(Type type, bool selected) {
    if (selected) {
      controller.addFilterType(type);
    } else {
      controller.removeFilterType(type);
    }
  }

  void _onToggleTitle(String title, bool selected) {
    if (selected) {
      controller.addFilterTitle(title);
    } else {
      controller.removeFilterTitle(title);
    }
  }

  Set<Type> get unicTypes {
    return Talker.instance.history.map((e) => e.runtimeType).toSet();
  }

  Set<String> get unicTitles {
    return Talker.instance.history.map((e) => e.displayTitle).toSet();
  }
}
