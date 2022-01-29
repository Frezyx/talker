import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenFilter extends StatelessWidget {
  const TalkerScreenFilter({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TalkerScreenController controller;

  @override
  Widget build(BuildContext context) {
    final types = unicTypes.map((e) => e.toString()).toList();
    return ListView(
      children: [
        const SizedBox(height: 10),
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
