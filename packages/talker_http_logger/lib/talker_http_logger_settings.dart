class TalkerHttpLoggerSettings {
  const TalkerHttpLoggerSettings({
    this.hiddenHeaders = const <String>{},
  });

  /// Header values for the specified keys in the Set will be replaced with *****.
  /// Case insensitive
  final Set<String> hiddenHeaders;
}
