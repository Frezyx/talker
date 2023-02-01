import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerAppScreen extends StatelessWidget {
  const TalkerAppScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dioInteceptor = GetIt.instance<TalkerDioLogger>();
    return TalkerScreen(
      talker: GetIt.instance<Talker>(),
      aditionalSettings: [
        AdditionalTalkerSetting(
          title: 'Print request data',
          value: dioInteceptor.settings.printRequestData,
          onChanged: (val) => dioInteceptor.configure(printRequestData: val),
        ),
        AdditionalTalkerSetting(
          title: 'Print response data',
          value: dioInteceptor.settings.printResponseData,
          onChanged: (val) => dioInteceptor.configure(printResponseData: val),
        ),
      ],
    );
  }
}
