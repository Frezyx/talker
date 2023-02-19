import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:talker_flutter/src/controller/controller.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerScreenFilter extends StatelessWidget {
  const TalkerScreenFilter({
    Key? key,
    required this.controller,
    required this.talkerScreenTheme,
    required this.talker,
    required this.typesController,
    required this.titlesController,
  }) : super(key: key);

  final TalkerScreenController controller;
  final TalkerScreenTheme talkerScreenTheme;
  final TalkerInterface talker;
  final GroupButtonController typesController;
  final GroupButtonController titlesController;

  @override
  Widget build(BuildContext context) {
    final titles = unicTitles.map((e) => e.toString()).toList();
    final types = unicTypes.map((e) => e).toList();
    final theme = Theme.of(context);
    return BaseBottomSheet(
      title: 'Talker Filter',
      talkerScreenTheme: talkerScreenTheme,
      child: Expanded(
        child: ListView(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: talkerScreenTheme.textColor,
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
                    color: talkerScreenTheme.textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Titles',
                style: theme.textTheme.titleLarge!.copyWith(
                  color: talkerScreenTheme.textColor,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GroupButton(
                isRadio: false,
                buttons: titles,
                controller: titlesController,
                onSelected: (_, i, selected) {
                  _onToggleTitle(titles[i], selected);
                },
                options: GroupButtonOptions(
                  mainGroupAlignment: MainGroupAlignment.start,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Types',
                style: theme.textTheme.titleLarge!.copyWith(
                  color: talkerScreenTheme.textColor,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GroupButton(
                isRadio: false,
                controller: typesController,
                buttons: types.map((e) => e.toString()).toList(),
                onSelected: (_, i, selected) {
                  _onToggleType(types[i], selected);
                },
                options: GroupButtonOptions(
                  mainGroupAlignment: MainGroupAlignment.start,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
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
    return talker.history.map((e) => e.runtimeType).toSet();
  }

  Set<String> get unicTitles {
    return talker.history.map((e) => e.displayTitle).toSet();
  }
}
