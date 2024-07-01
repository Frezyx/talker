import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerDataCard extends StatefulWidget {
  const TalkerDataCard({
    Key? key,
    required this.data,
    this.onCopyTap,
    this.onTap,
    this.expanded = false,
    this.margin,
    required this.color,
  }) : super(key: key);

  final TalkerData data;
  final VoidCallback? onCopyTap;
  final VoidCallback? onTap;
  final bool expanded;
  final EdgeInsets? margin;
  final Color color;

  @override
  State<TalkerDataCard> createState() => _TalkerDataCardState();
}

class _TalkerDataCardState extends State<TalkerDataCard> {
  var _expanded = false;

  @override
  void initState() {
    _expanded = widget.expanded;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _expanded = widget.expanded;
  }

  @override
  void didUpdateWidget(covariant TalkerDataCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _expanded = widget.expanded;
  }

  @override
  Widget build(BuildContext context) {
    final errorMessage = _errorMessage;
    final errorType = _type;
    final message = _message ?? _type;
    final stackTrace = _stackTrace;
    return Padding(
      padding: widget.margin ?? const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: _onTap,
        child: TalkerBaseCard(
          color: widget.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.data.title} | ${widget.data.displayTime}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        if (message != null)
                          Text(
                            message,
                            maxLines: _expanded ? null : 2,
                            style: const TextStyle(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 20,
                      icon: const Icon(Icons.copy),
                      onPressed: widget.onCopyTap,
                    ),
                  ),
                ],
              ),
              if (_expanded)
                Container(
                  width: double.infinity,
                  margin:
                      stackTrace != null ? const EdgeInsets.only(top: 8) : null,
                  padding: stackTrace != null
                      ? const EdgeInsets.all(6)
                      : EdgeInsets.zero,
                  decoration: stackTrace != null
                      ? BoxDecoration(borderRadius: BorderRadius.circular(10))
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_expanded && errorType != null && message == null)
                        Text(
                          errorType,
                          style: const TextStyle(fontSize: 12),
                        ),
                      if (_expanded && errorMessage != null)
                        Text(
                          errorMessage,
                          style: const TextStyle(fontSize: 12),
                        ),
                    ],
                  ),
                ),
              if (_expanded && stackTrace != null) ...[
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    stackTrace,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap?.call();
      return;
    }
    setState(() => _expanded = !_expanded);
  }

  String? get _stackTrace {
    if (widget.data is! TalkerError && widget.data is! TalkerException) {
      return null;
    }
    return 'StackTrace:\n${widget.data.stackTrace}';
  }

  String? get _message {
    if (widget.data is TalkerError || widget.data is TalkerException) {
      return null;
    }
    final isHttpLog = [
      TalkerLogType.httpError.key,
      TalkerLogType.httpRequest.key,
      TalkerLogType.httpResponse.key,
    ].contains(widget.data.title);
    if (isHttpLog) {
      return widget.data.generateTextMessage();
    }
    return widget.data.displayMessage;
  }

  String? get _errorMessage {
    var txt =
        widget.data.exception?.toString() ?? widget.data.exception?.toString();

    if ((txt?.isNotEmpty ?? false) && txt!.contains('Source stack:')) {
      txt = 'Data: ${txt.split('Source stack:').first.replaceAll('\n', '')}';
    }
    return txt;
  }

  String? get _type {
    if (widget.data is! TalkerError && widget.data is! TalkerException) {
      return null;
    }
    return 'Type: ${widget.data.exception?.runtimeType.toString() ?? widget.data.error?.runtimeType.toString() ?? ''}';
  }
}
