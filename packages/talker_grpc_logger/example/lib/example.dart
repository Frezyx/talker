import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:talker/talker.dart';
import 'package:talker_grpc_logger/talker_grpc_logger.dart';

// сгенерённые файлы из hello.proto
import 'hello.pbgrpc.dart';

Future<void> main() async {
  final talker = Talker();

  // Публичный echo-сервер Postman
  const host = 'grpc.postman-echo.com';
  const port = 443;

  // Включаем TLS (для localhost можно отключать)
  final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
    host: host,
    port: port,
    transportSecure: true,
  );

  final interceptors = <ClientInterceptor>[
    TalkerGrpcLogger(talker: talker),
  ];

  final client = HelloServiceClient(
    channel,
    interceptors: interceptors,
  );

  // 1) Unary
  final unary = await client.sayHello(
    HelloRequest(greeting: 'Привет от Flutter'),
  );
  talker.info('Unary reply: ${unary.reply}');

  // 2) Server-stream
  await for (final msg in client.lotsOfReplies(
    HelloRequest(greeting: 'Дай несколько ответов'),
  )) {
    talker.info('Stream reply: ${msg.reply}');
  }

  // 3) Client-stream
  final controller1 = StreamController<HelloRequest>();
  final clientStreamFuture = client.lotsOfGreetings(controller1.stream);
  controller1.add(HelloRequest(greeting: 'one'));
  controller1.add(HelloRequest(greeting: 'two'));
  await controller1.close();
  final clientStreamReply = await clientStreamFuture;
  talker.info('Client-stream summary: ${clientStreamReply.reply}');

  // 4) Bidi-stream
  final controller2 = StreamController<HelloRequest>();
  final bidiResponses = client.bidiHello(controller2.stream);
  final sub = bidiResponses.listen(
    (e) => talker.info('Bidi reply: ${e.reply}'),
    onError: talker.handle,
    onDone: () => talker.info('Bidi done'),
  );
  controller2.add(HelloRequest(greeting: 'hello'));
  controller2.add(HelloRequest(greeting: 'how are you?'));
  await controller2.close();
  await sub.asFuture();

  await channel.shutdown();
}
