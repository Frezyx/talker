import '../models/talker_data.dart';
import 'filters.dart';

/// {@template multi_talker_filter}
/// A [TalkerFilter] that chains multiple filters together.
///
/// A log entry is shown only when **all** filters approve it. The key and
/// search fields of [TalkerFilter] are applied together with [filters].
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
  const MultiTalkerFilter(
    this.filters, {
    super.enabledKeys,
    super.disabledKeys,
    super.searchQuery,
  });

  /// The filters to apply in order.
  final List<TalkerFilter> filters;

  @override
  bool filter(TalkerData item) =>
      super.filter(item) && filters.every((f) => f.filter(item));

  @override
  MultiTalkerFilter copyWith({
    List<String>? enabledKeys,
    List<String>? disabledKeys,
    String? searchQuery,
  }) =>
      MultiTalkerFilter(
        filters,
        enabledKeys: enabledKeys ?? this.enabledKeys,
        disabledKeys: disabledKeys ?? this.disabledKeys,
        searchQuery: searchQuery ?? this.searchQuery,
      );
}
