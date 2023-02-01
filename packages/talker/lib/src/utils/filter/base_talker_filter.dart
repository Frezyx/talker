import 'package:talker/talker.dart';

typedef TalkerFilter = Filter<TalkerDataInterface>;

abstract class Filter<T> {
  bool filter(T item);
}

class BaseTalkerFilter implements TalkerFilter {
  BaseTalkerFilter({
    this.titles = const [],
    this.types = const [],
    this.searchQuery,
  });

  final List<String> titles;
  final List<Type> types;
  final String? searchQuery;

  @override
  bool filter(TalkerDataInterface item) {
    var match = false;

    if (titles.isNotEmpty) {
      match = match || titles.contains(item.displayTitle);
    }

    if (types.isNotEmpty) {
      match = match || _checkTypeMatch(item);
    }

    if (searchQuery?.isNotEmpty ?? false) {
      final fullMsg = item.generateTextMessage();
      final fullUpperMsg = fullMsg.toUpperCase();
      final fullLowerMsg = fullMsg.toLowerCase();
      final textContain = fullUpperMsg.contains(searchQuery!) ||
          fullLowerMsg.contains(searchQuery!);
      match = match || textContain;
    }

    if (titles.isEmpty && types.isEmpty && (searchQuery?.isEmpty ?? true)) {
      match = true;
    }
    return match;
  }

  bool _checkTypeMatch(TalkerDataInterface item) {
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
    List<String>? titles,
    List<Type>? types,
    String? searchQuery,
  }) {
    return BaseTalkerFilter(
      titles: titles ?? this.titles,
      types: types ?? this.types,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
