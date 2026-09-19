import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:talker/talker.dart';
import 'package:talker_grpc_logger/talker_grpc_logger.dart';

import 'hello.pbgrpc.dart';

Future<void> main() async {
  try {
    final talker = Talker();

    final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: 'grpcb.in',
      port: 9000,
      transportSecure: false,
    );

    final client = HelloServiceClient(
      channel,
      interceptors: [
        _StubAuthHeaderInterceptor(),
        TalkerGrpcLogger(
          talker: talker,
          settings: const TalkerGrpcLoggerSettings(
            hiddenHeaders: {'authorization'},
            printStreamChunks: true,
          ),
        ),
      ],
    );

    try {
      await _sayHello(client, talker);
      await _lotsOfReplies(client, talker);
      await _lotsOfGreetings(client, talker);
      await _bidiHello(client, talker);
    } finally {
      await channel.shutdown();
    }
  } on GrpcError catch (_) {}
}

Future<void> _sayHello(HelloServiceClient client, Talker talker) async {
  talker.info('--- SayHello (unary) ---');
  final response = await client.sayHello(
    HelloRequest(greeting: 'Hello from unary'),
  );
  talker.info('Reply: ${response.reply}');
}

Future<void> _lotsOfReplies(
  HelloServiceClient client,
  Talker talker,
) async {
  talker.info('--- LotsOfReplies (server-stream) ---');
  await for (final response in client.lotsOfReplies(
    HelloRequest(greeting: 'Stream me a few'),
  )) {
    talker.info('Reply: ${response.reply}');
  }
}

Future<void> _lotsOfGreetings(
  HelloServiceClient client,
  Talker talker,
) async {
  talker.info('--- LotsOfGreetings (client-stream) ---');

  final controller = StreamController<HelloRequest>();
  final summary = client.lotsOfGreetings(controller.stream);

  controller.add(HelloRequest(greeting: 'one'));
  controller.add(HelloRequest(greeting: 'two'));
  controller.add(HelloRequest(greeting: 'three'));
  await controller.close();

  final response = await summary;
  talker.info('Summary: ${response.reply}');
}

Future<void> _bidiHello(HelloServiceClient client, Talker talker) async {
  talker.info('--- BidiHello (bidi-stream) ---');

  final controller = StreamController<HelloRequest>();
  final responses = client.bidiHello(controller.stream);

  final done = responses
      .listen(
        (r) => talker.info('Reply: ${r.reply}'),
        onError: talker.handle,
        onDone: () => talker.info('Bidi done'),
      )
      .asFuture();

  controller.add(HelloRequest(greeting: 'hello'));
  controller.add(HelloRequest(greeting: 'how are you?'));
  await controller.close();

  await done;
}

class _StubAuthHeaderInterceptor extends ClientInterceptor {
  static final Map<String, String> _headers = {
    'authorization': 'Bearer 12345678'
  };
  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    final mOptions = options.mergedWith(CallOptions(metadata: _headers));
    return invoker(method, requests, mOptions);
  }

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    final mOptions = options.mergedWith(CallOptions(metadata: _headers));
    return invoker(method, request, mOptions);
  }
}
