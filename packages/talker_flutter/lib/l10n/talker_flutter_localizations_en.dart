// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'talker_flutter_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class TalkerFlutterLocalizationsEn extends TalkerFlutterLocalizations {
  TalkerFlutterLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get talkerMonitor => 'Talker Monitor';

  @override
  String talkerMonitorType(String typeName) {
    return 'Talker Monitor $typeName';
  }

  @override
  String get settings => 'Settings';

  @override
  String get talkerSettings => 'Talker settings';

  @override
  String get packagesSettings => 'Packages settings';

  @override
  String get enabled => 'Enabled';

  @override
  String get useConsoleLogs => 'Use console logs';

  @override
  String get useHistory => 'Use history';

  @override
  String get reverseLogs => 'Reverse logs';

  @override
  String get copyAllLogs => 'Copy all logs';

  @override
  String get copyFilteredLogs => 'Copy filtered logs';

  @override
  String get expandLogs => 'Expand logs';

  @override
  String get collapseLogs => 'Collapse logs';

  @override
  String get cleanHistory => 'Clean history';

  @override
  String get shareLogsFile => 'Share logs file';

  @override
  String get logItemCopied => 'Log item is copied in clipboard';

  @override
  String get allLogsCopied => 'All logs copied in buffer';

  @override
  String get filteredLogsCopied => 'All filtered logs copied in buffer';

  @override
  String get undo => 'Undo';

  @override
  String get errors => 'Errors';

  @override
  String get exceptions => 'Exceptions';

  @override
  String get warnings => 'Warnings';

  @override
  String get infos => 'Infos';

  @override
  String get verboseDebug => 'Verbose & debug';

  @override
  String get httpRequests => 'Http Requests';

  @override
  String httpRequestsExecuted(int count) {
    return '$count http requests executed';
  }

  @override
  String successfulResponses(int count) {
    return '$count successful';
  }

  @override
  String get responsesReceived => ' responses received';

  @override
  String failureResponses(int count) {
    return '$count failure';
  }

  @override
  String unresolvedErrors(int count) {
    return 'Application has $count unresolved errors';
  }

  @override
  String unresolvedExceptions(int count) {
    return 'Application has $count unresolved exceptions';
  }

  @override
  String warningsCount(int count) {
    return 'Application has $count warnings';
  }

  @override
  String infoLogsCount(int count) {
    return 'Info logs count: $count';
  }

  @override
  String verboseDebugLogsCount(int count) {
    return 'Verbose and debug logs count: $count';
  }

  @override
  String get talkerActions => 'Talker Actions';

  @override
  String get errorOccurred => 'Error occurred';

  @override
  String get data => 'Data';

  @override
  String get type => 'Type';
}
