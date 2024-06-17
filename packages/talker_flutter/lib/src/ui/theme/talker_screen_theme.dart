import 'package:flutter/material.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';

typedef LogColors = Map<TalkerLogType, Color>;

extension MapTalkerFlutterColorsExt on LogColors {
  Color fromTalkerData(final TalkerData data) {
    final key = data.key;

    if (key == null) return Colors.grey;
    final type = TalkerLogType.fromKey(key);
    return getByType(type);
  }

  Color getByType(TalkerLogType type) {
    return this[type] ?? Colors.grey;
  }
}

const defaultColors = <TalkerLogType, Color>{
  /// Base logs section
  TalkerLogType.error: Color.fromARGB(255, 239, 83, 80),
  TalkerLogType.critical: Color.fromARGB(255, 198, 40, 40),
  TalkerLogType.info: Color.fromARGB(255, 66, 165, 245),
  TalkerLogType.debug: Color.fromARGB(255, 158, 158, 158),
  TalkerLogType.verbose: Color.fromARGB(255, 189, 189, 189),
  TalkerLogType.warning: Color.fromARGB(255, 239, 108, 0),
  TalkerLogType.exception: Color.fromARGB(255, 239, 83, 80),

  /// Http section
  TalkerLogType.httpError: Color.fromARGB(255, 239, 83, 80),
  TalkerLogType.httpRequest: Color(0xFFF602C1),
  TalkerLogType.httpResponse: Color(0xFF26FF3C),

  /// Bloc section
  TalkerLogType.blocEvent: Color(0xFF63FAFE),
  TalkerLogType.blocTransition: Color(0xFF56FEA8),
  TalkerLogType.blocClose: Color(0xFFFF005F),
  TalkerLogType.blocCreate: Color.fromARGB(255, 120, 230, 129),

  /// Flutter section
  TalkerLogType.route: Color(0xFFAF5FFF),
};
