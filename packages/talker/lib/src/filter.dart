import 'package:talker/talker.dart';

class TalkerFilter implements _Filter<TalkerData> {
  TalkerFilter({
    this.enabledKeys = const [],
    this.disabledKeys = const [],
    this.searchQuery,
  });

  /// List of enabled for filter keys
  /// This is a new way to filter logs by their keys.
  /// Keys are unique identifiers for logs, which can be set when creating a log.
  /// All original talker keys here [TalkerKey]
  final List<String> enabledKeys;

  /// List of disabled for filter keys
  /// This is a new way to filter logs by their keys.
  /// Keys are unique identifiers for logs, which can be set when creating a log.
  /// All original talker keys here [TalkerKey]
  final List<String> disabledKeys;

  /// String query for filtering logs
  final String? searchQuery;

  @override
  bool filter(TalkerData item) {
    var searchMatch = true;
    var enabledKeysMatch = true;
    var disabledKeysMatch = true;

    final query = searchQuery?.toLowerCase();
    if (query != null && query.isNotEmpty) {
      final message = item.generateTextMessage().toLowerCase();
      searchMatch = message.contains(query);
    }

    if (enabledKeys.isNotEmpty) {
      enabledKeysMatch = enabledKeys.contains(item.key);
    }

    if (disabledKeys.isNotEmpty) {
      disabledKeysMatch = !disabledKeys.contains(item.key);
    }

    return searchMatch && enabledKeysMatch && disabledKeysMatch;
  }

  TalkerFilter copyWith({
    List<String>? enabledKeys,
    List<String>? disabledKeys,
    String? searchQuery,
  }) {
    return TalkerFilter(
      enabledKeys: enabledKeys ?? this.enabledKeys,
      disabledKeys: disabledKeys ?? this.disabledKeys,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

abstract class _Filter<T> {
  bool filter(T item);
}
