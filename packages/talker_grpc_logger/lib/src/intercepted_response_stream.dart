import 'dart:async';

import 'package:grpc/grpc.dart';

/// A proxy wrapper implementing [ResponseStream] that safely intercepts
/// stream events without changing observable behavior.
///
/// Interception is layered on top of Dart's own stream operators
/// ([Stream.map], [Stream.handleError], [StreamTransformer]), so the
/// callbacks fire even for consumers that replace the subscription's
/// callbacks after [listen] — `drain`, `single`, `first`, `last` all use
/// `asFuture` internally and would otherwise bypass a wrapper that returns
/// the raw subscription from the source stream.
///
/// ### `single` and client-streaming RPCs
///
/// Generated gRPC clients for **client-streaming** methods are shaped like
/// `$createStreamingCall(...).single` — the terminal `.single` is applied
/// by the generated code, not by the caller. Without special handling,
/// that would delegate to the wrapped [ResponseStream] and silently skip
/// [onResponse] / [onComplete]. To keep logging consistent across all
/// three streaming shapes, [single] is routed through [_intercepted] via
/// a minimal [ClientCall] adapter.
class InterceptedResponseStream<R> extends Stream<R>
    implements ResponseStream<R> {
  InterceptedResponseStream(
    this._originalStream, {
    required this.onResponse,
    required this.onError,
    this.onComplete,
  }) {
    _intercepted = _originalStream.map<R>((message) {
      onResponse(message);
      return message;
    }).handleError((Object error, StackTrace stackTrace) {
      onError(error);
      Error.throwWithStackTrace(error, stackTrace);
    }).transform(
      StreamTransformer<R, R>.fromHandlers(
        handleDone: (sink) {
          onComplete?.call();
          sink.close();
        },
      ),
    );
  }

  final ResponseStream<R> _originalStream;

  /// Called for every chunk emitted by the underlying stream.
  final void Function(R) onResponse;

  /// Called when the underlying stream emits an error.
  final void Function(Object) onError;

  /// Called when the underlying stream emits `done`.
  ///
  /// Not called on error and not called when the subscription is cancelled
  /// before the source completes.
  final void Function()? onComplete;

  late final Stream<R> _intercepted;

  /// Every consumer goes through `_intercepted`, so events and callbacks are
  /// applied uniformly for `listen`, `toList`, `drain`, `first`, `single`,
  /// `forEach`, `fold`, `map`, `where`, `timeout`, and everything else that
  /// [Stream] provides.
  @override
  StreamSubscription<R> listen(
    void Function(R event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _intercepted.listen(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
      );

  @override
  bool get isBroadcast => _intercepted.isBroadcast;

  @override
  Future<Map<String, String>> get headers => _originalStream.headers;

  @override
  Future<Map<String, String>> get trailers => _originalStream.trailers;

  @override
  ResponseFuture<R> get single {
    final completer = Completer<R>();
    var count = 0;
    late R firstValue;

    final sub = _intercepted.listen(
      (value) {
        count++;
        if (count == 1) {
          firstValue = value;
        } else if (count == 2 && !completer.isCompleted) {
          // Mirror grpc's ResponseFuture behavior: reject on the second
          // element rather than waiting for done.
          completer.completeError(
            GrpcError.unimplemented('More than one response received'),
          );
        }
      },
      onError: (Object e, StackTrace st) {
        if (!completer.isCompleted) completer.completeError(e, st);
      },
      onDone: () {
        if (completer.isCompleted) return;
        if (count == 0) {
          completer.completeError(
            GrpcError.unimplemented('No responses received'),
          );
        } else if (count == 1) {
          completer.complete(firstValue);
        }
      },
      cancelOnError: true,
    );

    return ResponseFuture<R>(
      _SingleCall<R>(
        response: Stream.fromFuture(completer.future),
        original: _originalStream,
        cancelUnderlying: sub.cancel,
      ),
    );
  }

  @override
  Future<void> cancel() => _originalStream.cancel();
}

class _SingleCall<R> implements ClientCall<dynamic, R> {
  _SingleCall({
    required Stream<R> response,
    required ResponseStream<R> original,
    required Future<void> Function() cancelUnderlying,
  })  : _response = response,
        _original = original,
        _cancelUnderlying = cancelUnderlying;

  final Stream<R> _response;
  final ResponseStream<R> _original;
  final Future<void> Function() _cancelUnderlying;

  @override
  Stream<R> get response => _response;

  @override
  Future<Map<String, String>> get headers => _original.headers;

  @override
  Future<Map<String, String>> get trailers => _original.trailers;

  @override
  Future<void> cancel() async {
    await _cancelUnderlying();
    await _original.cancel();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('_SingleCall: $invocation');
}
