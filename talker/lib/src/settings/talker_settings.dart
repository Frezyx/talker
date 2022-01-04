const kDefaultTalkerSettings = TalkerSettings();

class TalkerSettings {
  const TalkerSettings({
    this.useHistory = true,
    this.maxHistoryEntries = 200,
    this.writeToFile = true,
  });

  final bool useHistory;
  final int maxHistoryEntries;
  final bool writeToFile;
}
