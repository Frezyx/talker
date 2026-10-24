import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

/// Hides log entries backed by a [GrpcError].
///
/// Works with both [TalkerError] (checks `error`) and [TalkerException]
/// (checks `exception`). The key and search fields of [TalkerFilter] are
/// applied together with this check.
class ExcludeGrpcErrorFilter extends TalkerFilter {
  const ExcludeGrpcErrorFilter({
    super.enabledKeys,
    super.disabledKeys,
    super.searchQuery,
  });

  @override
  bool filter(TalkerData item) => super.filter(item) && !_isGrpcError(item);

  static bool _isGrpcError(TalkerData item) =>
      (item is TalkerError && item.error is GrpcError) ||
      (item is TalkerException && item.exception is GrpcError);

  @override
  ExcludeGrpcErrorFilter copyWith({
    List<String>? enabledKeys,
    List<String>? disabledKeys,
    String? searchQuery,
  }) =>
      ExcludeGrpcErrorFilter(
        enabledKeys: enabledKeys ?? this.enabledKeys,
        disabledKeys: disabledKeys ?? this.disabledKeys,
        searchQuery: searchQuery ?? this.searchQuery,
      );
}
