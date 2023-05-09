enum WellKnownTitles {
  error,
  exception,
}

extension WellKnownTitlesExt on WellKnownTitles {
  String get title {
    switch (this) {
      case WellKnownTitles.error:
        return 'ERROR';
      case WellKnownTitles.exception:
        return 'EXCEPTION';
    }
  }
}
