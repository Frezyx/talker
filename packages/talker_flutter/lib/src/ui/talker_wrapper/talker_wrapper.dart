import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/snackbar.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'talker_wrapper_options.dart';

/// Widget to wrap an screen or the entire application
/// in [Talker] data listerning
///
/// This is used to display error
/// and exeption messages via [TalkerListener]
///
/// [TalkerWrapperOptions] options used to customize and filtering
/// error and exceptions messages output
class TalkerWrapper extends StatelessWidget {
  const TalkerWrapper({
    Key? key,
    required this.talker,
    required this.child,
    this.options = const TalkerWrapperOptions(),
  }) : super(key: key);

  final Talker talker;
  final Widget child;
  final TalkerWrapperOptions options;

  @override
  Widget build(BuildContext context) {
    return TalkerListener(
      talker: talker,
      listener: (data) {
        if (data is TalkerException && options.enableExceptionAlerts) {
          showAlert(
            context,
            options.exceptionAlertBuilder?.call(context, data) ??
                SnackbarContent(
                  message: _mapErrorMessage(data.displayException),
                  title: options.errorTitle,
                ),
          );
          return;
        }
        if (data is TalkerError && options.enableErrorAlerts) {
          showAlert(
            context,
            options.errorAlertBuilder?.call(context, data) ??
                SnackbarContent(
                  message: _mapErrorMessage(data.displayError),
                  title: options.errorTitle,
                ),
          );
        }
      },
      child: child,
    );
  }

  String _mapErrorMessage(String errorMessage) {
    final errorParts = errorMessage.split('\n');
    if (errorParts.length < 2) {
      return errorMessage;
    }
    return errorParts.getRange(1, 2).join('\n');
  }

  static void showAlert(BuildContext context, Widget content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: content,
      ),
    );
  }
}
