class TalkerBlocLoggerSettings {
  const TalkerBlocLoggerSettings({
    this.enabled = true,
    this.printEventFullData = true,
    this.printStateFullData = true,
  });

  final bool enabled;
  final bool printEventFullData;
  final bool printStateFullData;
}
