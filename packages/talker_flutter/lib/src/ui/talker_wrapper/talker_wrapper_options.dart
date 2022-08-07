part of 'talker_wrapper.dart';

typedef TalkerErrorBuilder = Widget Function(
  BuildContext context,
  TalkerError data,
);

typedef TalkerExceptionBuilder = Widget Function(
  BuildContext context,
  TalkerException data,
);

class TalkerWrapperOptions {
  const TalkerWrapperOptions({
    this.exceptionTitle = 'Error occurred',
    this.exceptionAlertBuilder,
    this.errorAlertBuilder,
    this.enableErrorAlerts = false,
    this.enableExceptionAlerts = true,
  });

  final String exceptionTitle;
  final TalkerExceptionBuilder? exceptionAlertBuilder;
  final TalkerErrorBuilder? errorAlertBuilder;
  final bool enableErrorAlerts;
  final bool enableExceptionAlerts;
}
