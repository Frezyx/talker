import 'dart:async' show FutureOr;

import 'package:chopper/chopper.dart';

class JsonHeadersInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) =>
      chain.proceed(
        applyHeader(
          chain.request,
          "accept",
          "application/json; charset=utf-8",
        ),
      );
}
