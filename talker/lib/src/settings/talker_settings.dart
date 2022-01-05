const kDefaultTalkerSettings = TalkerSettings();

class TalkerSettings {
  const TalkerSettings({
    this.useHistory = true,
    this.maxHistoryItems = 200,
    this.writeToFile = false,
  });

  final bool useHistory;
  final int maxHistoryItems;
  final bool writeToFile;
}
