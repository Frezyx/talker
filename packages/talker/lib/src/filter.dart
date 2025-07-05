import 'package:talker/talker.dart';

class TalkerFilter implements _Filter<TalkerData> {
  TalkerFilter({
    this.keys = const [],
    this.searchQuery,
  });

  /// List of enabled for filter keys
  /// This is a new way to filter logs by their keys.
  /// Keys are unique identifiers for logs, which can be set when creating a log.
  /// All original talker keys here [TalkerKey]
  final List<String> keys;

  /// String query for filtering logs
  final String? searchQuery;

  @override
  bool filter(TalkerData item) {
    var searchMatch = true;
    var keysMatch = true;

    final query = searchQuery?.toLowerCase();
    if (query != null && query.isNotEmpty) {
      final message = item.generateTextMessage().toLowerCase();
      searchMatch = message.contains(query);
    }

    if (keys.isNotEmpty) {
      keysMatch = keys.contains(item.key);
    }

    return searchMatch && keysMatch;
  }

  TalkerFilter copyWith({
    List<String>? keys,
    String? searchQuery,
  }) {
    return TalkerFilter(
      keys: keys ?? this.keys,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

abstract class _Filter<T> {
  bool filter(T item);
}
