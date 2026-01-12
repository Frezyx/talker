part of 'talker_wrapper.dart';

/// Options for [TalkerWrapper]
class TalkerWrapperOptions {
  const TalkerWrapperOptions({
    this.exceptionTitle = 'Error occurred',
    this.errorTitle = 'Error occurred',
    this.logTitle = 'Log message',
    this.exceptionAlertBuilder,
    this.errorAlertBuilder,
    this.logAlertBuilder,
    this.enableErrorAlerts = false,
    this.enableExceptionAlerts = true,
    this.enableLogAlerts = true,
  });

  /// Used for custom snackbar title
  final String exceptionTitle;

  /// Used for custom snackbar title
  final String errorTitle;

  /// Used for custom snackbar title
  final String logTitle;

  /// Field for customizing the displayed exception widget
  final TalkerExceptionBuilder? exceptionAlertBuilder;

  /// Field for customizing the displayed error widget
  final TalkerErrorBuilder? errorAlertBuilder;

  /// Field for customizing the displayed log widget
  final TalkerDataBuilder? logAlertBuilder;

  /// [TalkerWrapper] will show error message if field is [true]
  final bool enableErrorAlerts;

  /// [TalkerWrapper] will show exceptions message if field is [true]
  final bool enableExceptionAlerts;

  /// [TalkerWrapper] will show exceptions message if field is [true]
  final bool enableLogAlerts;
}
