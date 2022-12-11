import 'package:flutter/material.dart';
import 'package:talker_dio_logger/http_logs.dart';
import 'package:talker_flutter/src/ui/widgets/cards/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerDataCard extends StatelessWidget {
  const TalkerDataCard({
    Key? key,
    this.color,
    required this.data,
    this.onTap,
    this.expanded = true,
  }) : super(key: key);

  final Color? color;
  final TalkerDataInterface data;
  final VoidCallback? onTap;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final errorMessage = _errorMessage;
    final color = this.color ?? _color;
    final errorType = _type;
    final message = _message;
    final stackTrace = _stackTrace;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TalkerBaseCard(
        color: color,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    data.displayTitle + ' | ' + data.displayTime,
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                IconButton(
                  constraints: BoxConstraints.loose(const Size.fromHeight(26)),
                  onPressed: onTap,
                  icon: Icon(Icons.copy, color: color, size: 20),
                )
              ],
            ),
            Container(
              margin: stackTrace != null ? const EdgeInsets.only(top: 8) : null,
              padding: stackTrace != null
                  ? const EdgeInsets.all(6)
                  : EdgeInsets.zero,
              decoration: stackTrace != null
                  ? BoxDecoration(
                      color: Colors.grey[900],
                      borderRadius: BorderRadius.circular(10),
                    )
                  : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (errorType != null)
                    Text(
                      errorType,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                      ),
                    ),
                  if (expanded && errorMessage != null)
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: color,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
            if (expanded && message != null)
              Text(
                message,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              ),
            if (expanded && stackTrace != null)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  stackTrace,
                  style: TextStyle(
                    color: color,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  String? get _stackTrace {
    if (data is! TalkerError && data is! TalkerException) {
      return null;
    }
    return 'StackTrace:\n' + data.stackTrace.toString();
  }

  Color get _color {
    if (data is TalkerFlutterAdapterInterface) {
      return (data as TalkerFlutterAdapterInterface).color ??
          data.logLevel.color;
    }
    if (data is HttpErrorLog) {
      return LogLevel.error.color;
    }
    if (data is HttpResponseLog) {
      return const Color(0xFF26FF3C);
    }
    if (data is HttpRequestLog) {
      return const Color(0xFFB800AF);
    }

    return data.logLevel.color;
  }

  String? get _message {
    if (data is TalkerError || data is TalkerException) {
      return null;
    }
    return data.displayMessage;
  }

  String? get _errorMessage {
    var txt = data.exception?.toString() ?? data.exception?.toString();

    if ((txt?.isNotEmpty ?? false) && txt!.contains('Source stack:')) {
      txt = 'Data: ' + txt.split('Source stack:').first.replaceAll('\n', '');
    }
    return txt;
  }

  String? get _type {
    if (data is! TalkerError && data is! TalkerException) {
      return null;
    }
    return 'Type: ' +
        (data.exception?.runtimeType.toString() ??
            data.error?.runtimeType.toString() ??
            '');
  }
}
