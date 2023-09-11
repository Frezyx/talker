import 'package:flutter/material.dart';

class SnackbarContent extends StatelessWidget {
  const SnackbarContent({
    Key? key,
    required this.message,
    required this.title,
    this.backgroundColor = Colors.red,
    this.dismissButton,
    this.titleTextStyle,
    this.messageTextStyle,
    this.dismissButtonText,
  }) : super(key: key);

  final String title;
  final String message;
  final String? dismissButtonText;
  final Color backgroundColor;
  final Widget? dismissButton;
  final TextStyle? titleTextStyle;
  final TextStyle? messageTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        style: titleTextStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        message,
                        style: messageTextStyle ??
                            const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          dismissButton ??
              TextButton(
                onPressed: () => _closeSnackbar(context),
                child: Text(dismissButtonText ?? "Undo"),
              )
        ],
      ),
    );
  }

  void _closeSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
