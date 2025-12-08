import 'package:flutter/material.dart';
import 'package:talker_flutter/src/ui/widgets/base_card.dart';
import 'package:talker_flutter/talker_flutter.dart';

class TalkerDataCard extends StatefulWidget {
  const TalkerDataCard({
    Key? key,
    required this.data,
    this.onCopyTap,
    this.onTap,
    this.expanded = true,
    this.margin,
    required this.color,
    this.backgroundColor = defaultCardBackgroundColor,
  }) : super(key: key);

  final TalkerData data;
  final VoidCallback? onCopyTap;
  final VoidCallback? onTap;
  final bool expanded;
  final EdgeInsets? margin;
  final Color color;
  final Color backgroundColor;

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
    final message = _message;
    final stackTrace = _stackTrace;
    return Padding(
      padding: widget.margin ?? const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: _onTap,
        child: TalkerBaseCard(
          color: widget.color,
          backgroundColor: widget.backgroundColor,
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
                          '${widget.data.title} | ${widget.data.displayTime()}',
                          style: TextStyle(
                            color: widget.color,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        if (message != null)
                          Text(
                            message,
                            maxLines: _expanded ? null : 2,
                            style: TextStyle(
                              color: widget.color,
                              fontSize: 12,
                            ),
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
                      icon: Icon(
                        Icons.copy,
                        color: widget.color,
                      ),
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
                      ? BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(10),
                        )
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_expanded && errorType != null)
                        Text(
                          errorType,
                          style: TextStyle(
                            color: widget.color,
                            fontSize: 12,
                          ),
                        ),
                      if (_expanded && errorMessage != null)
                        Text(
                          errorMessage,
                          style: TextStyle(
                            color: widget.color,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ),
              if (_expanded && stackTrace != null)
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
                      color: widget.color,
                      fontSize: 12,
                    ),
                  ),
                ),
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
    // For HTTP logs, always use the generated text message which includes formatted content
    final isHttpLog = [
      TalkerKey.httpError,
      TalkerKey.httpRequest,
      TalkerKey.httpResponse,
    ].contains(widget.data.key);
    if (isHttpLog) {
      return widget.data.generateTextMessage();
    }
    
    // For custom logs that override generateTextMessage(), detect by checking
    // if the generated message differs significantly from just the raw message.
    // This is a heuristic approach that works for most common cases.
    final generatedMessage = widget.data.generateTextMessage();
    final rawMessage = widget.data.displayMessage;
    
    // If the generated message contains additional content beyond just the raw message
    // (excluding title/time which are shown separately), use the generated message
    if (rawMessage.isNotEmpty && generatedMessage.contains(rawMessage)) {
      // Check if generated message has additional content beyond title/time/message
      // by looking for newlines or additional text
      if (generatedMessage.contains('\n') || 
          generatedMessage.length > rawMessage.length + 50) {
        return generatedMessage;
      }
    }
    
    return rawMessage;
  }

  String? get _errorMessage {
    var txt =
        widget.data.exception?.toString() ?? widget.data.error?.toString();

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
