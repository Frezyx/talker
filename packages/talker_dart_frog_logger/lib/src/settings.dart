class TalkerDartFrogLoggerSettings {
  const TalkerDartFrogLoggerSettings({
    this.logRequest = true,
    this.logResponse = true,
    this.printRequestHeaders = false,
    this.printResponseHeaders = false,
    this.printResponseBody = false,
  });

  final bool logRequest;
  final bool logResponse;
  final bool printRequestHeaders;
  final bool printResponseHeaders;
  final bool printResponseBody;
}
