const kDefaultTalkerSettings = TalkerSettings();

class TalkerSettings {
  const TalkerSettings({
    this.useHistory = true,
    this.maxHistoryEntries = 200,
  });

  final bool useHistory;
  final int maxHistoryEntries;
}
