import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenFilter extends StatelessWidget {
  const TalkerScreenFilter({
    Key? key,
  }) : super(key: key);

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
            onSelected: (selected, i) {},
            mainGroupAlignment: MainGroupAlignment.start,
          ),
        )
      ],
    );
  }

  Set<String> get unicTypes {
    return Talker.instance.history.map((e) => e.displayTitle).toSet();
  }
}
