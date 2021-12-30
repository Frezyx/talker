const kDefaultErrorHandlerSettings = ErrorHandlerSettings();

class ErrorHandlerSettings {
  const ErrorHandlerSettings({
    this.useHistory = true,
    this.maxHistoryEntries = 200,
  });

  final bool useHistory;
  final int maxHistoryEntries;
}
