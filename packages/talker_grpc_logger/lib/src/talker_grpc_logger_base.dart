/// Implements a gRPC interceptor that logs requests and responses to Talker.
/// https://pub.dev/documentation/grpc/latest/grpc/ClientInterceptor-class.html
import 'package:talker/talker.dart';
import 'package:grpc/grpc.dart';

import 'grpc_logs.dart';


class TalkerGrpcLogger extends ClientInterceptor {
  TalkerGrpcLogger({Talker? talker, this.obfuscateToken = true}) {
    _talker = talker ?? Talker();
  }

  late Talker _talker;
  final bool obfuscateToken;

  @override
  ResponseFuture<R> interceptUnary<Q, R>(ClientMethod<Q, R> method, Q request,
      CallOptions options, ClientUnaryInvoker<Q, R> invoker) {
    _talker.logTyped(GrpcRequestLog(method.path,
        method: method,
        request: request,
        options: options,
        obfuscateToken: obfuscateToken));

    DateTime startTime = DateTime.now();
    final response = invoker(method, request, options);

    response.then((r) {
      Duration elapsedTime = DateTime.now().difference(startTime);
      _talker.logTyped(GrpcResponseLog(method.path,
          method: method, response: r, durationMs: elapsedTime.inMilliseconds));
    }).catchError((e) {
      Duration elapsedTime = DateTime.now().difference(startTime);
      _talker.logTyped(GrpcErrorLog(method.path,
          method: method,
          request: request,
          options: options,
          grpcError: e,
          durationMs: elapsedTime.inMilliseconds,
          obfuscateToken: obfuscateToken));
    });
    return response;
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
      ClientMethod<Q, R> method,
      Stream<Q> requests,
      CallOptions options,
      ClientStreamingInvoker<Q, R> invoker) {
    print('interceptStreaming');

    return invoker(method, requests, options);
  }
}

