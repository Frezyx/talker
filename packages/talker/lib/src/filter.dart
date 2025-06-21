import 'package:talker/talker.dart';

typedef TalkerFilter = _Filter<TalkerData>;

class BaseTalkerFilter implements TalkerFilter {
  BaseTalkerFilter({
    @Deprecated('Use keys instead. This feature will be removed in v5.0.0')
    this.titles = const [],
    @Deprecated('Use keys instead. This feature will be removed in v5.0.0')
    this.types = const [],
    this.keys = const [],
    this.searchQuery,
  });

  /// List of enabled for filter titles [exception], [error], [verbose]
  @Deprecated('Use keys instead. This feature will be removed in v5.0.0')
  final List<String> titles;

  /// List of enabled for filter types - subclasses of [TalkerData]
  /// Like [TalkerError], [TalkerException], [TalkerLog], etc.
  @Deprecated('Use keys instead. This feature will be removed in v5.0.0')
  final List<Type> types;

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
      return searchMatch && keysMatch;
    }

    /// Old filter logic for titles and types
    /// This is deprecated and will be removed in v5.0.0
    // ignore: deprecated_member_use_from_same_package
    return _oldFilterLogic(item);
  }

  @Deprecated('This method will be removed in v5.0.0')
  bool _oldFilterLogic(TalkerData item) {
    if (titles.isEmpty && types.isEmpty && (searchQuery?.isEmpty ?? true)) {
      return true;
    } else {
      var match = false;

      if (searchQuery?.isNotEmpty ?? false) {
        final fullMsg = item.generateTextMessage();
        final fullUpperMsg = fullMsg.toUpperCase();
        final fullLowerMsg = fullMsg.toLowerCase();
        match = fullUpperMsg.contains(searchQuery!) ||
            fullLowerMsg.contains(searchQuery!);
      }

      return (titles.contains(item.title) || titles.isEmpty) &&
          (_checkTypeMatch(item) || types.isEmpty) &&
          (match || (searchQuery?.isEmpty ?? true));
    }
  }

  @Deprecated('This method will be removed in v5.0.0')
  bool _checkTypeMatch(TalkerData item) {
    var match = false;
    for (final type in types) {
      if (item.runtimeType == type) {
        match = true;
        break;
      }
    }
    return match;
  }

  BaseTalkerFilter copyWith({
    @Deprecated('Use keys instead. This feature will be removed in v5.0.0')
    List<String>? titles,
    @Deprecated('Use keys instead. This feature will be removed in v5.0.0')
    List<Type>? types,
    String? searchQuery,
  }) {
    return BaseTalkerFilter(
      // ignore: deprecated_member_use_from_same_package
      titles: titles ?? this.titles,
      // ignore: deprecated_member_use_from_same_package
      types: types ?? this.types,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

abstract class _Filter<T> {
  bool filter(T item);
}
