class TalkerDioLoggerSettings {
  const TalkerDioLoggerSettings({
    this.printResponseData = true,
    this.printRequestData = true,
    this.printResponseHeaders = false,
    this.printRequestHeaders = false,
  });

  final bool printResponseData;
  final bool printRequestData;
  final bool printResponseHeaders;
  final bool printRequestHeaders;
}
