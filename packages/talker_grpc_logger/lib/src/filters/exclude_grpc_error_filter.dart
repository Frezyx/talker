import 'package:grpc/grpc.dart';
import 'package:talker/talker.dart';

/// Hides log entries backed by a [GrpcError].
///
/// Works with both [TalkerError] (checks `error`) and [TalkerException]
/// (checks `exception`). All other behavior is delegated to [TalkerFilter].
class ExcludeGrpcErrorFilter extends TalkerFilter {
  const ExcludeGrpcErrorFilter();

  @override
  bool filter(TalkerData item) =>
      !((item is TalkerError && item.error is GrpcError) ||
          (item is TalkerException && item.exception is GrpcError));
}
