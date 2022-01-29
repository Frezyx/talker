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
    final types = unicTypes.map((e) => e.toString()).toList();
    final theme = Theme.of(context);
    return ListView(
      children: [
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
            buttons: types,
            onSelected: (i, selected) {
              _onToggleTitle(types, i, selected);
            },
            mainGroupAlignment: MainGroupAlignment.start,
          ),
        )
      ],
    );
  }

  void _onToggleTitle(List<String> types, int i, bool selected) {
    final type = types[i];
    if (selected) {
      controller.addFilterTitle(type);
    } else {
      controller.removeFilterTitle(type);
    }
  }

  Set<String> get unicTypes {
    return Talker.instance.history.map((e) => e.displayTitle).toSet();
  }
}
