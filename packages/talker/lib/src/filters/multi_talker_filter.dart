import '../models/talker_data.dart';
import 'filters.dart';

/// {@template multi_talker_filter}
/// A [TalkerFilter] that chains multiple filters together.
///
/// A log entry is shown only when **all** filters approve it.
///
/// ```dart
/// final talker = Talker(
///   filter: MultiTalkerFilter([
///     ExcludeGrpcErrorFilter(),
///     MyCustomFilter(),
///   ]),
/// );
/// ```
/// {@endtemplate}
class MultiTalkerFilter extends TalkerFilter {
  /// {@macro multi_talker_filter}
  const MultiTalkerFilter(this.filters);

  /// The filters to apply in order.
  final List<TalkerFilter> filters;

  @override
  bool filter(TalkerData item) => filters.every((f) => f.filter(item));
}
