/// [TalkerDioLogger] settings and customization
class TalkerDioLoggerSettings {
  const TalkerDioLoggerSettings({
    this.printResponseData = true,
    this.printRequestData = true,
    this.printResponseHeaders = false,
    this.printRequestHeaders = false,
  });

  /// Print [response.data] if true
  final bool printResponseData;

  /// Print [request.data] if true
  final bool printRequestData;

  /// Print [response.headers] if true
  final bool printResponseHeaders;

  /// Print [request.headers] if true
  final bool printRequestHeaders;
}
