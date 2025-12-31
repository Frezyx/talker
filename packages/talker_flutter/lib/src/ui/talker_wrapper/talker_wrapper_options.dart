part of 'talker_wrapper.dart';

/// Options for [TalkerWrapper]
class TalkerWrapperOptions {
  const TalkerWrapperOptions({
    String? exceptionTitle,
    String? errorTitle,
    this.exceptionAlertBuilder,
    this.errorAlertBuilder,
    this.enableErrorAlerts = false,
    this.enableExceptionAlerts = true,
  })  : _exceptionTitle = exceptionTitle,
        _errorTitle = errorTitle;

  /// Used for custom snackbar title
  final String? _exceptionTitle;

  /// Used for custom snackbar title
  final String? _errorTitle;

  /// Get exception title with fallback to localized string
  String exceptionTitle(BuildContext context) =>
      _exceptionTitle ?? context.l10n.errorOccurred;

  /// Get error title with fallback to localized string
  String errorTitle(BuildContext context) =>
      _errorTitle ?? context.l10n.errorOccurred;

  /// Field for customizing the displayed exception widget
  final TalkerExceptionBuilder? exceptionAlertBuilder;

  /// Field for customizing the displayed error widget
  final TalkerErrorBuilder? errorAlertBuilder;

  /// [TalkerWrapper] will show error message if field is [true]
  final bool enableErrorAlerts;

  /// [TalkerWrapper] will show exceptions message if field is [true]
  final bool enableExceptionAlerts;
}
