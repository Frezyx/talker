import '../models/talker_data.dart';
import 'filters.dart';

/// {@template simple_talker_filter}
/// A [TalkerFilter] whose decision is made by a single [condition] callback.
///
/// The key and search fields of [TalkerFilter] are ignored.
///
/// Usually created via [TalkerFilter.simple].
/// {@endtemplate}
class SimpleTalkerFilter extends TalkerFilter {
  /// {@macro simple_talker_filter}
  const SimpleTalkerFilter(this.condition);

  /// Predicate that decides whether a log passes the filter.
  ///
  /// Returns `true` to show the log, `false` to hide it.
  final bool Function(TalkerData item) condition;

  @override
  bool filter(TalkerData item) => condition(item);
}
