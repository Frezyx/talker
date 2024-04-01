import 'package:grpc/grpc.dart';
import 'package:grpc/grpc_or_grpcweb.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_grpc_logger/talker_grpc_logger.dart';

void main() {
  // Not mandatory, but useful to see the grpc logs in the Talker screen
  final talker = TalkerFlutter.init();

  // Define port and host as you see fit
  var host = 'localhost';
  var port = 50051;

  // transportSecure needs to be true when talking to a server through TLS.
  // This can be disabled for local development.
  // GrpcOrGrpcWebClientChannel is a channel type compatible with web and native. There
  // are other channel types available for each platform.
  late final channel = GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: host,
      port: port,
      transportSecure: host == 'localhost' ? false : true);


  final List<ClientInterceptor> interceptors = [
    TalkerGrpcLogger(talker: talker)
  ];

  // Generate your RPC client as usual, and use the interceptor to log the requests and responses.
  late final rpcClient = YourRPCClient(channel, interceptors: interceptors);
}
