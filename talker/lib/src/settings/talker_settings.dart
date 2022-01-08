const kDefaultTalkerSettings = TalkerSettings();

class TalkerSettings {
  const TalkerSettings({
    this.useHistory = true,
    this.useConsoleLogs = true,
    this.maxHistoryItems = 200,
    this.writeToFile = false,
  });

  final bool useHistory;
  final bool useConsoleLogs;
  final int maxHistoryItems;
  final bool writeToFile;
}
