class TalkerBlocLoggerSettings {
  const TalkerBlocLoggerSettings({
    required this.enabled,
    required this.printEventFullData,
    required this.printStateFullData,
  });

  final bool enabled;
  final bool printEventFullData;
  final bool printStateFullData;
}
