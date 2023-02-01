import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/bottom_sheet.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerSettingsBottomSheet extends StatelessWidget {
  const TalkerSettingsBottomSheet({
    Key? key,
    required this.talkerScreenTheme,
    required this.talker,
    required this.settings,
    // this.additionalSettings,
  }) : super(key: key);

  /// Theme for customize [TalkerScreen]
  final TalkerScreenTheme talkerScreenTheme;

  /// Talker implementation
  final TalkerInterface talker;

  final List<Widget> settings;

  // final List<AdditionalTalkerSetting>? additionalSettings;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: 'Talker Settings',
      talkerScreenTheme: talkerScreenTheme,
      child: Expanded(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ...settings.map((e) => SliverToBoxAdapter(child: e)),

            // if (additionalSettings != null)
            //   ...additionalSettings!
            //       .map(
            //         (e) => SliverToBoxAdapter(
            //           child: TalkerSettingsCard(
            //             talkerScreenTheme: talkerScreenTheme,
            //             title: e.title,
            //             enabled: e.value,
            //             onChanged: (v) {
            //               e.onChanged(v);
            //             },
            //           ),
            //         ),
            //       )
            //       .toList(),
          ],
        ),
      ),
    );
  }
}
