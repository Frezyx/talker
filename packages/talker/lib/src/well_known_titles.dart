enum WellKnownTitles {
  error,
  exception,
  httpError,
  httpRequest,
  httpResponse,
  blocEvent,
  blocTransition,
  route,
}

extension WellKnownTitlesExt on WellKnownTitles {
  //TODO: customization from Talker constructor
  String get title {
    final titles = {
      WellKnownTitles.error: 'ERROR',
      WellKnownTitles.exception: 'EXCEPTION',
      WellKnownTitles.httpError: 'http-error',
      WellKnownTitles.httpRequest: 'http-request',
      WellKnownTitles.httpResponse: 'http-response',
      WellKnownTitles.blocEvent: 'bloc-event',
      WellKnownTitles.blocTransition: 'bloc-transition',
      WellKnownTitles.route: 'ROUTE',
    };
    return titles[this] ?? 'log';
  }
}
