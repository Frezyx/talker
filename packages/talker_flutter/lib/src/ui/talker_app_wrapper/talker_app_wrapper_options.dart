part of 'talker_app_wrapper.dart';

/// Options for [TalkerAppWrapper]
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

  /// [TalkerAppWrapper] will show error message if field is [true]
  final bool enableErrorAlerts;

  /// [TalkerAppWrapper] will show exceptions message if field is [true]
  final bool enableExceptionAlerts;
}
