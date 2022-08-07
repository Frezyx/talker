import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'talker_wrapper_options.dart';

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
        if (data is TalkerException) {
          _showExceptionAlert(context, data);
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
        content: _SnackbarContent(
          data: data,
          title: options.exceptionTitle,
        ),
      ),
    );
  }
}

class _SnackbarContent extends StatelessWidget {
  const _SnackbarContent({
    Key? key,
    required this.data,
    required this.title,
    this.color,
  }) : super(key: key);

  final TalkerException data;
  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color ?? Colors.red,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
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
                  data.exception.toString(),
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
