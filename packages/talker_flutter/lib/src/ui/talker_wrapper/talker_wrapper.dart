import 'package:flutter/material.dart';
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
      child: child,
      talker: talker,
      listener: (data) {
        if (data is TalkerException && options.enableExceptionAlerts) {
          _showExceptionAlert(context, data);
          return;
        }
        if (data is TalkerError && options.enableErrorAlerts) {
          _showErrorAlert(context, data);
        }
      },
    );
  }

  void _showExceptionAlert(BuildContext context, TalkerException data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: options.exceptionAlertBuilder?.call(context, data) ??
            _SnackbarContent(
              message: data.exception.toString(),
              title: options.exceptionTitle,
            ),
      ),
    );
  }

  void _showErrorAlert(BuildContext context, TalkerError data) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: EdgeInsets.zero,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: options.errorAlertBuilder?.call(context, data) ??
            _SnackbarContent(
              message: data.error.toString(),
              title: options.errorTitle,
            ),
      ),
    );
  }
}

class _SnackbarContent extends StatelessWidget {
  const _SnackbarContent({
    Key? key,
    required this.message,
    required this.title,
  }) : super(key: key);

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 4),
          const Icon(Icons.warning, color: Colors.white),
          const SizedBox(width: 12),
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _closeSnackbar(context),
            child: const Text("Undo"),
          )
        ],
      ),
    );
  }

  void _closeSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
