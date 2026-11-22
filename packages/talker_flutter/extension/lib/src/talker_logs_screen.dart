import 'dart:async';
import 'dart:convert';

import 'package:devtools_extensions/devtools_extensions.dart';
import 'package:flutter/material.dart';

const String _extensionMethod = 'ext.talker_flutter.getLogs';
const Duration _pollInterval = Duration(seconds: 1);

/// Console-style screen that fetches and displays Talker logs from the app
/// via VM Service Extension.
class TalkerLogsScreen extends StatefulWidget {
  const TalkerLogsScreen({super.key});

  @override
  State<TalkerLogsScreen> createState() => _TalkerLogsScreenState();
}

class _TalkerLogsScreenState extends State<TalkerLogsScreen> {
  final List<Map<String, dynamic>> _logs = [];
  int _lastSeenIndex = -1;
  Timer? _pollTimer;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_fetchLogs());
    _pollTimer = Timer.periodic(_pollInterval, (_) => unawaited(_fetchLogs()));
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchLogs() async {
    if (!serviceManager.connectedState.value.connected) {
      if (mounted) {
        setState(() {
          _error = 'No app connected. Run your app in debug mode.';
          _loading = false;
        });
      }
      return;
    }

    try {
      final isInitialLoad = _lastSeenIndex < 0;
      final args = _lastSeenIndex >= 0 ? {'since': '$_lastSeenIndex'} : null;
      final response = await serviceManager.callServiceExtensionOnMainIsolate(
        _extensionMethod,
        args: args,
      );

      var json = response.json;
      if (json != null && json.containsKey('result') && json['result'] is String) {
        json = jsonDecode(json['result'] as String) as Map<String, dynamic>?;
      }
      if (json == null) return;

      final total = json['total'] as int? ?? 0;
      final newLogs = json['logs'] as List<dynamic>?;
      if (newLogs == null) return;

      if (isInitialLoad) {
        _logs.clear();
        for (final entry in newLogs) {
          if (entry is Map<String, dynamic>) _logs.add(entry);
        }
        _lastSeenIndex = total > 0 ? total - 1 : -1;
      } else {
        for (final entry in newLogs) {
          if (entry is Map<String, dynamic>) {
            final index = entry['index'] as int?;
            if (index != null && index > _lastSeenIndex) {
              _lastSeenIndex = index;
            }
            _logs.add(entry);
          }
        }
      }

      if (mounted) {
        setState(() {
          _error = null;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Failed to fetch logs: $e';
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talker Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _logs.clear();
                _lastSeenIndex = -1;
                _loading = true;
              });
              unawaited(_fetchLogs());
            },
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            _error!,
            style: TextStyle(color: Theme.of(context).colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_loading && _logs.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_logs.isEmpty) {
      return const Center(
        child: Text('No logs yet. Use Talker in your app to see logs here.'),
      );
    }

    return ListView.builder(
      itemCount: _logs.length,
      itemBuilder: (context, index) {
        return _LogEntryTile(log: _logs[index]);
      },
    );
  }
}

class _LogEntryTile extends StatefulWidget {
  const _LogEntryTile({required this.log});

  final Map<String, dynamic> log;

  @override
  State<_LogEntryTile> createState() => _LogEntryTileState();
}

class _LogEntryTileState extends State<_LogEntryTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final log = widget.log;
    final message = log['message'] as String? ?? '';
    final title = log['title'] as String? ?? 'log';
    final logLevel = log['logLevel'] as String? ?? 'debug';
    final time = log['time'] as String? ?? '';
    final stackTrace = log['stackTrace'] as String?;
    final exception = log['exception'] as String?;
    final error = log['error'] as String?;
    final hasDetails = (stackTrace != null && stackTrace.isNotEmpty) ||
        (exception != null && exception.isNotEmpty) ||
        (error != null && error.isNotEmpty);

    final color = _colorForLevel(logLevel);

    return Material(
      color: _expanded ? Theme.of(context).colorScheme.surfaceContainerHighest : null,
      child: InkWell(
        onTap: hasDetails
            ? () => setState(() => _expanded = !_expanded)
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 140,
                    child: Text(
                      time.length > 19 ? time.substring(11, 19) : time,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: 'monospace',
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      logLevel.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontFamily: 'monospace',
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SelectableText(
                      '[$title] $message',
                      style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
                    ),
                  ),
                  if (hasDetails)
                    Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      size: 20,
                    ),
                ],
              ),
              if (_expanded && hasDetails) ...[
                const SizedBox(height: 8),
                if (exception != null && exception.isNotEmpty)
                  _DetailBlock(title: 'Exception', content: exception),
                if (error != null && error.isNotEmpty)
                  _DetailBlock(title: 'Error', content: error),
                if (stackTrace != null && stackTrace.isNotEmpty)
                  _DetailBlock(title: 'StackTrace', content: stackTrace),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Color _colorForLevel(String level) {
    switch (level.toLowerCase()) {
      case 'critical':
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.blue;
      case 'debug':
        return Colors.grey;
      case 'verbose':
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}

class _DetailBlock extends StatelessWidget {
  const _DetailBlock({required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              content,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
