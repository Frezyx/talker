import 'package:talker/src/src.dart';

abstract class Filter<T> {
  bool filter(T item);
}

class TalkerFilter implements Filter<TalkerDataInterface> {
  TalkerFilter({
    required this.titles,
  });

  final List<String> titles;

  @override
  bool filter(TalkerDataInterface item) {
    if (titles.isEmpty) {
      return true;
    }
    return titles.contains(item.displayTitle);
  }

  TalkerFilter copyWith({
    List<String>? titles,
  }) {
    return TalkerFilter(
      titles: titles ?? this.titles,
    );
  }
}
