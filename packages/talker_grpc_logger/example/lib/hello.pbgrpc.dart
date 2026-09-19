// This is a generated file - do not edit.
//
// Generated from hello.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'hello.pb.dart' as $0;

export 'hello.pb.dart';

@$pb.GrpcServiceName('hello.HelloService')
class HelloServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  HelloServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.HelloResponse> sayHello(
    $0.HelloRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$sayHello, request, options: options);
  }

  $grpc.ResponseStream<$0.HelloResponse> lotsOfReplies(
    $0.HelloRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(
        _$lotsOfReplies, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.HelloResponse> lotsOfGreetings(
    $async.Stream<$0.HelloRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$lotsOfGreetings, request, options: options)
        .single;
  }

  $grpc.ResponseStream<$0.HelloResponse> bidiHello(
    $async.Stream<$0.HelloRequest> request, {
    $grpc.CallOptions? options,
  }) {
    return $createStreamingCall(_$bidiHello, request, options: options);
  }

  // method descriptors

  static final _$sayHello =
      $grpc.ClientMethod<$0.HelloRequest, $0.HelloResponse>(
          '/hello.HelloService/SayHello',
          ($0.HelloRequest value) => value.writeToBuffer(),
          $0.HelloResponse.fromBuffer);
  static final _$lotsOfReplies =
      $grpc.ClientMethod<$0.HelloRequest, $0.HelloResponse>(
          '/hello.HelloService/LotsOfReplies',
          ($0.HelloRequest value) => value.writeToBuffer(),
          $0.HelloResponse.fromBuffer);
  static final _$lotsOfGreetings =
      $grpc.ClientMethod<$0.HelloRequest, $0.HelloResponse>(
          '/hello.HelloService/LotsOfGreetings',
          ($0.HelloRequest value) => value.writeToBuffer(),
          $0.HelloResponse.fromBuffer);
  static final _$bidiHello =
      $grpc.ClientMethod<$0.HelloRequest, $0.HelloResponse>(
          '/hello.HelloService/BidiHello',
          ($0.HelloRequest value) => value.writeToBuffer(),
          $0.HelloResponse.fromBuffer);
}

@$pb.GrpcServiceName('hello.HelloService')
abstract class HelloServiceBase extends $grpc.Service {
  $core.String get $name => 'hello.HelloService';

  HelloServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloResponse>(
        'SayHello',
        sayHello_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloResponse>(
        'LotsOfReplies',
        lotsOfReplies_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloResponse>(
        'LotsOfGreetings',
        lotsOfGreetings,
        true,
        false,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.HelloRequest, $0.HelloResponse>(
        'BidiHello',
        bidiHello,
        true,
        true,
        ($core.List<$core.int> value) => $0.HelloRequest.fromBuffer(value),
        ($0.HelloResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.HelloResponse> sayHello_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.HelloRequest> $request) async {
    return sayHello($call, await $request);
  }

  $async.Future<$0.HelloResponse> sayHello(
      $grpc.ServiceCall call, $0.HelloRequest request);

  $async.Stream<$0.HelloResponse> lotsOfReplies_Pre(
      $grpc.ServiceCall $call, $async.Future<$0.HelloRequest> $request) async* {
    yield* lotsOfReplies($call, await $request);
  }

  $async.Stream<$0.HelloResponse> lotsOfReplies(
      $grpc.ServiceCall call, $0.HelloRequest request);

  $async.Future<$0.HelloResponse> lotsOfGreetings(
      $grpc.ServiceCall call, $async.Stream<$0.HelloRequest> request);

  $async.Stream<$0.HelloResponse> bidiHello(
      $grpc.ServiceCall call, $async.Stream<$0.HelloRequest> request);
}
