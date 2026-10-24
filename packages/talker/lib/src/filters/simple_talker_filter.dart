import '../models/talker_data.dart';
import 'filters.dart';

/// {@template simple_talker_filter}
/// A [TalkerFilter] whose decision is made by a single [condition] callback.
///
/// The key and search fields of [TalkerFilter] are applied together with
/// [condition]: a log passes only when it satisfies both.
///
/// Usually created via [TalkerFilter.simple].
/// {@endtemplate}
class SimpleTalkerFilter extends TalkerFilter {
  /// {@macro simple_talker_filter}
  const SimpleTalkerFilter(
    this.condition, {
    super.enabledKeys,
    super.disabledKeys,
    super.searchQuery,
  });

  /// Predicate that decides whether a log passes the filter.
  ///
  /// Returns `true` to show the log, `false` to hide it.
  final bool Function(TalkerData item) condition;

  @override
  bool filter(TalkerData item) => super.filter(item) && condition(item);

  @override
  SimpleTalkerFilter copyWith({
    List<String>? enabledKeys,
    List<String>? disabledKeys,
    String? searchQuery,
  }) =>
      SimpleTalkerFilter(
        condition,
        enabledKeys: enabledKeys ?? this.enabledKeys,
        disabledKeys: disabledKeys ?? this.disabledKeys,
        searchQuery: searchQuery ?? this.searchQuery,
      );
}
