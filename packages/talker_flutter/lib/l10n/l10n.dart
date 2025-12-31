import 'package:flutter/widgets.dart';
import 'package:talker_flutter/l10n/talker_flutter_localizations.dart';
import 'package:talker_flutter/l10n/talker_flutter_localizations_en.dart';

export 'package:talker_flutter/l10n/talker_flutter_localizations.dart';

/// Extension to safely access localizations with English as default
extension BuildContextL10n on BuildContext {
  /// Get AppLocalizations with fallback to English
  TalkerFlutterLocalizations get l10n =>
      TalkerFlutterLocalizations.of(this) ?? TalkerFlutterLocalizationsEn();
}
