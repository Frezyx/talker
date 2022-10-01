part of 'talker_wrapper.dart';

/// Options for [TalkerWrapper]
class TalkerWrapperOptions {
  const TalkerWrapperOptions({
    this.exceptionTitle = 'Error occurred',
    this.errorTitle = 'Error occurred',
    this.exceptionAlertBuilder,
    this.errorAlertBuilder,
    this.enableErrorAlerts = false,
    this.enableExceptionAlerts = true,
  });

  /// Used for custom snackbar title
  final String exceptionTitle;

  /// Used for custom snackbar title
  final String errorTitle;

  /// Field for customizing the displayed exception widget
  final TalkerExceptionBuilder? exceptionAlertBuilder;

  /// Field for customizing the displayed error widget
  final TalkerErrorBuilder? errorAlertBuilder;

  /// [TalkerWrapper] will show error message if field is [true]
  final bool enableErrorAlerts;

  /// [TalkerWrapper] will show exceptions message if field is [true]
  final bool enableExceptionAlerts;
}
