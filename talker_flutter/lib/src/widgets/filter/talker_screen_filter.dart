import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenFilter extends StatelessWidget {
  const TalkerScreenFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        GroupButton.checkbox(
          buttons: unicTypes.map((e) => e.toString()).toList(),
          onSelected: (selected, i) {},
        )
      ],
    );
  }

  Set<String> get unicTypes {
    return Talker.instance.history.map((e) => e.displayTitle).toSet();
  }
}
