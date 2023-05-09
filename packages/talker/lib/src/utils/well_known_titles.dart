enum WellKnownTitles {
  error,
  exception,
  httpError,
  httpRequest,
  httpResponse,
}

extension WellKnownTitlesExt on WellKnownTitles {
  String get title {
    switch (this) {
      case WellKnownTitles.error:
        return 'ERROR';
      case WellKnownTitles.exception:
        return 'EXCEPTION';
      case WellKnownTitles.httpError:
        return 'http-error';
      case WellKnownTitles.httpRequest:
        return 'http-request';
      case WellKnownTitles.httpResponse:
        return 'http-response';
    }
  }
}
