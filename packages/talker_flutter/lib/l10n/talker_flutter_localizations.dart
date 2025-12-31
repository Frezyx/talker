import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'talker_flutter_localizations_en.dart';
import 'talker_flutter_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of TalkerFlutterLocalizations
/// returned by `TalkerFlutterLocalizations.of(context)`.
///
/// Applications need to include `TalkerFlutterLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/talker_flutter_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: TalkerFlutterLocalizations.localizationsDelegates,
///   supportedLocales: TalkerFlutterLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the TalkerFlutterLocalizations.supportedLocales
/// property.
abstract class TalkerFlutterLocalizations {
  TalkerFlutterLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static TalkerFlutterLocalizations? of(BuildContext context) {
    return Localizations.of<TalkerFlutterLocalizations>(
        context, TalkerFlutterLocalizations);
  }

  static const LocalizationsDelegate<TalkerFlutterLocalizations> delegate =
      _TalkerFlutterLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// Title for talker monitor screen
  ///
  /// In en, this message translates to:
  /// **'Talker Monitor'**
  String get talkerMonitor;

  /// Title for typed logs screen
  ///
  /// In en, this message translates to:
  /// **'Talker Monitor {typeName}'**
  String talkerMonitorType(String typeName);

  /// Settings menu title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Talker settings section header
  ///
  /// In en, this message translates to:
  /// **'Talker settings'**
  String get talkerSettings;

  /// Packages settings section header
  ///
  /// In en, this message translates to:
  /// **'Packages settings'**
  String get packagesSettings;

  /// Label for enabled toggle
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get enabled;

  /// Setting for console logs
  ///
  /// In en, this message translates to:
  /// **'Use console logs'**
  String get useConsoleLogs;

  /// Setting for history
  ///
  /// In en, this message translates to:
  /// **'Use history'**
  String get useHistory;

  /// Action to reverse logs order
  ///
  /// In en, this message translates to:
  /// **'Reverse logs'**
  String get reverseLogs;

  /// Action to copy all logs
  ///
  /// In en, this message translates to:
  /// **'Copy all logs'**
  String get copyAllLogs;

  /// Action to copy filtered logs
  ///
  /// In en, this message translates to:
  /// **'Copy filtered logs'**
  String get copyFilteredLogs;

  /// Action to expand all logs
  ///
  /// In en, this message translates to:
  /// **'Expand logs'**
  String get expandLogs;

  /// Action to collapse all logs
  ///
  /// In en, this message translates to:
  /// **'Collapse logs'**
  String get collapseLogs;

  /// Action to clean history
  ///
  /// In en, this message translates to:
  /// **'Clean history'**
  String get cleanHistory;

  /// Action to share logs file
  ///
  /// In en, this message translates to:
  /// **'Share logs file'**
  String get shareLogsFile;

  /// Snackbar message when log item copied
  ///
  /// In en, this message translates to:
  /// **'Log item is copied in clipboard'**
  String get logItemCopied;

  /// Snackbar message when all logs copied
  ///
  /// In en, this message translates to:
  /// **'All logs copied in buffer'**
  String get allLogsCopied;

  /// Snackbar message when filtered logs copied
  ///
  /// In en, this message translates to:
  /// **'All filtered logs copied in buffer'**
  String get filteredLogsCopied;

  /// Undo button text
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Errors label
  ///
  /// In en, this message translates to:
  /// **'Errors'**
  String get errors;

  /// Exceptions label
  ///
  /// In en, this message translates to:
  /// **'Exceptions'**
  String get exceptions;

  /// Warnings label
  ///
  /// In en, this message translates to:
  /// **'Warnings'**
  String get warnings;

  /// Info logs label
  ///
  /// In en, this message translates to:
  /// **'Infos'**
  String get infos;

  /// Verbose and debug logs label
  ///
  /// In en, this message translates to:
  /// **'Verbose & debug'**
  String get verboseDebug;

  /// HTTP requests label
  ///
  /// In en, this message translates to:
  /// **'Http Requests'**
  String get httpRequests;

  /// HTTP requests count message
  ///
  /// In en, this message translates to:
  /// **'{count} http requests executed'**
  String httpRequestsExecuted(int count);

  /// Successful responses count
  ///
  /// In en, this message translates to:
  /// **'{count} successful'**
  String successfulResponses(int count);

  /// Responses received suffix
  ///
  /// In en, this message translates to:
  /// **' responses received'**
  String get responsesReceived;

  /// Failure responses count
  ///
  /// In en, this message translates to:
  /// **'{count} failure'**
  String failureResponses(int count);

  /// Unresolved errors message
  ///
  /// In en, this message translates to:
  /// **'Application has {count} unresolved errors'**
  String unresolvedErrors(int count);

  /// Unresolved exceptions message
  ///
  /// In en, this message translates to:
  /// **'Application has {count} unresolved exceptions'**
  String unresolvedExceptions(int count);

  /// Warnings count message
  ///
  /// In en, this message translates to:
  /// **'Application has {count} warnings'**
  String warningsCount(int count);

  /// Info logs count message
  ///
  /// In en, this message translates to:
  /// **'Info logs count: {count}'**
  String infoLogsCount(int count);

  /// Verbose and debug logs count message
  ///
  /// In en, this message translates to:
  /// **'Verbose and debug logs count: {count}'**
  String verboseDebugLogsCount(int count);

  /// Talker actions bottom sheet title
  ///
  /// In en, this message translates to:
  /// **'Talker Actions'**
  String get talkerActions;

  /// Default error/exception title
  ///
  /// In en, this message translates to:
  /// **'Error occurred'**
  String get errorOccurred;

  /// Data label prefix
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// Type label prefix
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;
}

class _TalkerFlutterLocalizationsDelegate
    extends LocalizationsDelegate<TalkerFlutterLocalizations> {
  const _TalkerFlutterLocalizationsDelegate();

  @override
  Future<TalkerFlutterLocalizations> load(Locale locale) {
    return SynchronousFuture<TalkerFlutterLocalizations>(
        lookupTalkerFlutterLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_TalkerFlutterLocalizationsDelegate old) => false;
}

TalkerFlutterLocalizations lookupTalkerFlutterLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return TalkerFlutterLocalizationsEn();
    case 'zh':
      return TalkerFlutterLocalizationsZh();
  }

  throw FlutterError(
      'TalkerFlutterLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
