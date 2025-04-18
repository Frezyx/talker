import 'dart:async' show FutureOr;

import 'package:chopper/chopper.dart' show Chain, Request, Response;
import 'package:http/http.dart' as http;

/// A fake implementation of [Chain] for testing purposes.
class FakeChain<BodyType> implements Chain<BodyType> {
  FakeChain(
    this.request, {
    this.response,
    this.exception,
  }) : assert(
          response == null || exception == null,
          'Either response or exception must be provided, not both.',
        );

  @override
  final Request request;

  /// The fake response to be returned by the chain.
  final Response? response;

  /// The fake exception to be returned by the chain.
  final Exception? exception;

  @override
  FutureOr<Response<BodyType>> proceed(Request request) {
    if (exception != null) {
      throw exception!;
    }

    if (response != null) {
      return response as Response<BodyType>;
    }

    return Response<BodyType>(
      http.Response('TestChain', 200),
      'TestChain' as BodyType,
    );
  }
}
