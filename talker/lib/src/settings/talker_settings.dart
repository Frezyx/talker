const kDefaultTalkerSettings = TalkerSettings();

class TalkerSettings {
  const TalkerSettings({
    this.useHistory = true,
    this.maxHistoryItems = 200,
    this.writeToFile = true,
  });

  final bool useHistory;
  final int maxHistoryItems;
  final bool writeToFile;
}
