enum TalkerOriginalAddons {
  talkerDioLogger,
  talkerBlocLogger,
}

/// enhanced-enums don't used to save dart sdk version on >2.15
extension TalkerOriginalAddonsExt on TalkerOriginalAddons {
  String get code {
    switch (this) {
      case TalkerOriginalAddons.talkerDioLogger:
        return 'talker_dio_logger';
      case TalkerOriginalAddons.talkerBlocLogger:
        return 'talker_bloc_logger';
    }
  }
}
