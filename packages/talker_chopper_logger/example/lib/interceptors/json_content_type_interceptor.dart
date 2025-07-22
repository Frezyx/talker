import 'dart:async' show FutureOr;

import 'package:chopper/chopper.dart';

class JsonContentTypeInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(Chain<BodyType> chain) =>
      switch (chain.request.method) {
        HttpMethod.Post || HttpMethod.Put || HttpMethod.Patch => chain.proceed(
            applyHeader(
              chain.request,
              "content-type",
              "application/json; charset=utf-8",
            ),
          ),
        _ => chain.proceed(chain.request),
      };
}
