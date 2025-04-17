import 'dart:async' show FutureOr;

import 'package:chopper/chopper.dart' show Request, Response, Chain;
import 'package:http/http.dart' as http;

/// A fake implementation of [Chain] for testing purposes.
class FakeChain<BodyType> implements Chain<BodyType> {
  FakeChain(this.request, [this.response]);

  @override
  final Request request;

  /// The fake response to be returned by the chain.
  final Response? response;

  @override
  FutureOr<Response<BodyType>> proceed(Request request) =>
      response as Response<BodyType>? ??
      Response(http.Response('TestChain', 200), 'TestChain' as BodyType);
}
