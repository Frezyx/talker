# 4.8.0
- [talker_flutter] Add custom settings section

Thanks to [zvikarp](https://github.com/zvikarp)

# 4.7.9
- [talker_bloc_logger] show full data of Bloc logs in Flutter Talker

Thanks to [Mooyeee](https://github.com/Mooyeee)

# 4.7.8
- [talker_flutter] fix: respect custom TalkerLogger output in TalkerFlutter.init

Thanks to [techouse](https://github.com/techouse)

# 4.7.7
- [talker_logger] chore: update logger output type for improved clarity

Thanks to [techouse](https://github.com/techouse)

# 4.7.6
- [talker_flutter] fix: propagate `itemsBuilder` to `TalkerView`

Thanks to [AhmedEzio47](https://github.com/AhmedEzio47)

# 4.7.5
- Update example application dependencies

Thanks to [apps/renovate](https://github.com/apps/renovate)

# 4.7.4
- [talker_dio_logger] Add logLevel field to provide in all dIo logs

Thanks to [mylukin](https://github.com/mylukin)

# 4.7.3
- [talker_flutter] Fixed missing info and detailed message for exceptions

Thanks to [salarshad](https://github.com/salarshad)

# 4.7.2
- [talker_dio_logger] Add response time to logs
- Add ``printResponseTime`` field for ``TalkerDioLoggerSettings`` to turn on/off response time printing

Thanks to [troyanskiy](https://github.com/troyanskiy)

# 4.7.1
- [talker_flutter] Fix scroll issue and widget usability with high text scale

Thanks to [federicoviceconti](https://github.com/federicoviceconti)

# 4.7.0
- [talker_flutter] Remove deprecated dart:html
- [talker_logger] Remove deprecated dart:html

Thanks to [Mooyeee](https://github.com/Mooyeee)

# 4.6.14
- [talker] Fix search filtering rules<br>
  Now ``titles && types && searchQuery`` replace ``titles || types || searchQuery`` logic

Thanks to [N1X41](https://github.com/N1X41)

# 4.6.13
- [talker_dio_logger] Fix ``hiddenHeaders`` alters the request headers

Thanks to [amrgetment](https://github.com/amrgetment)

# 4.6.12
- [talker_flutter] Rename conflict extension `firstWhereOrNull` from `collection`

Thanks to [Bogdan778](https://github.com/Bogdan778)

# 4.6.11
- [talker_dio_logger] Add `printResponseRedirects` field into `TalkerDioLoggerSettings` to print Response redirects

Thanks to [federicoviceconti](https://github.com/federicoviceconti)

# 4.6.10
- [talker_flutter] Fix search textfield background color become white in light theme

Thanks to [asadman1523](https://github.com/asadman1523)

# 4.6.9
- [talker] Fix CustomLogs ``pen`` field ignoring by console [issue#313](https://github.com/Frezyx/talker/issues/313)

# 4.6.8
- [talker_dio_logger] Fix substitution of hidden headers ``hiddenHeaders`` field in ``TalkerDioLoggerSettings``

# 4.6.7
- [talker_http_logger] Add settings ``TalkerLoggerSettings`` field to setup http logger settings
- [talker_http_logger] Add ``hiddenHeaders`` field in ``TalkerLoggerSettings`` to hide specific and sensitive http logger headers

Thanks to [Ilushnik](https://github.com/Ilushnik)

# 4.6.6
- [talker_dio_logger] Add ``hiddenHeaders`` field in ``TalkerDioLoggerSettings`` to hide specific and sensitive dio logger headers

Thanks to [Ilushnik](https://github.com/Ilushnik)

# 4.6.5
- [talker_bloc_logger] Bump bloc version to 9.0.0

# 4.6.4
- [talker_flutter] Proper migration of support to the web using both html and wasm
- [talker_flutter] Update example dart sdk version to '>=3.6.0 <4.0.0'

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

# 4.6.3
- [talker_flutter] Correction the import file name in the talker_flutter log downloader web

Thanks to [samanzamani](https://github.com/samanzamani)

# 4.6.2
- [talker_flutter] Migrate downloadLogs export to new js_interop package

# 4.6.1
- [talker_flutter] Add new web api support for download logs file

# 4.6.0
- [talker_flutter] Add support WASM for Flutter Web
- [talker_flutter] Support flutter 3.27, remove deprecations

Thanks to [abdelaziz-mahdy](https://github.com/abdelaziz-mahdy)

# 4.5.6
- [talker_flutter] Add copy functionality for filtered logs

Thanks to [abdelaziz-mahdy](https://github.com/abdelaziz-mahdy)

# 4.5.5
- [talker] Add history logging filter by LogLevel
- [talker_flutter] Fix TalkerScreen does not respect configured LogLevel setting

Thanks to [mylukin](https://github.com/mylukin)

# 4.5.4
- [talker_flutter] Add isLogsExpanded and isLogOrderReversed flags to TalkerScreen widget

Thanks to [Ilushnik](https://github.com/Ilushnik) 

# 4.5.3
- [talker_http_logger] Add HttpErrorLog for wrong http statuses

Thanks to [yelmuratoff](https://github.com/yelmuratoff) 

# 4.5.2
- [talker_flutter] Add fallback Flutter screen log card color by LogLevel

# 4.5.1
- [talker_flutter] Fix mapping LogColors to Flutter Color (Logs screen)

# 4.5.0
More Flexible Interaction with Custom Logs  
- **BREAKING** [talker] Change the type of `colors` parameter in the `TalkerSettings` class from `Map<TalkerLogType, AnsiPen>?` to `Map<String, AnsiPen>?`. Custom colors must now use a string key for log types.  
- **BREAKING** [talker] Change the type of `titles` parameter in the `TalkerSettings` class from `Map<TalkerLogType, String>?` to `Map<String, String>?`. Custom titles must now use a string key for log types.  
- **BREAKING** [talker_flutter] Change the type of `colors` parameter in the **TalkerScreenTheme** class from `Map<TalkerLogType, Colors>?` to `Map<String, Colors>?`. Custom colors must now use a string key for log types.  
- [talker] Add new tests and updated existing ones.  
- [talker] Update the documentation for log customization.

Thanks to [yelmuratoff](https://github.com/yelmuratoff) 

# 4.4.7
- [talker_dio_logger] Make encoder constant private

# 4.4.6
- [talker] Reanme **logTyped** method to **logCustom**
- [talker] Add **Deprecated** annotation for logTyped method

# 4.4.5
- [talker_logger] Add enable option field to control log output (on talker_logger level)

Thanks to [weitsai](https://github.com/weitsai)

# 4.4.4
- [talker_dio_logger] Add enable option field to control log output (on talker_dio_logger level)

Thanks to [weitsai](https://github.com/weitsai)

# 4.4.3
- [talker_http_logger] Bump http_interceptor package version to **2.0.0**

# 4.4.2
- [talker] Fix provide pen color field in log() method
- [talker] Android dependecies actualization and bug fixing in example app code

Thanks to [HE-LU](https://github.com/HE-LU) and [venkat9507](https://github.com/venkat9507)

# 4.4.1
- [talker_flutter] Bump share_plus version to 10.0.1
- [talker_flutter] Bump path_provider version to 2.1.4

# 4.4.0
- [talker] Stable ```TimeFormat``` release (Support of custom time formatting for every talker package)
- [talker_riverpod_logger] Bump version to talker common versions system

# 1.1.5
- [talker_bloc_logger] Setup common time format from talker settings for Bloc logs

# 1.1.4
- [talker_riverpod_logger] Duplicated state logs fixes

Thanks to [ArinFaraj](https://github.com/ArinFaraj)

# 1.1.3
- [talker_bloc_logger] Fix bloc logs TimeFormat

Thanks to [Mooyeee](https://github.com/Mooyeee)

# 1.1.2
- [talker_riverpod_logger] Fix issue with display time inside riverpod package

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

# 1.1.1
- [talker_flutter] Fix showing times on FlutterScreen cards

Thanks to [fieldOfView](https://github.com/fieldOfView)

# 1.1.0
- [talker_flutter] Custom logs timestamp formattings

Thanks to [abdelaziz-mahdy](https://github.com/abdelaziz-mahdy)

# 1.0.4
- [talker_riverpod_logger] Print missing data on TalkerScreen 

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

# 1.0.3
- [talker_riverpod_logger] Include Provider's name in logs output

# 1.0.2
- [talker_flutter] Support for Flutter 3.22, fix new version deprecations

# 1.0.1
- [talker_dio_logger] Add missing error setting for **TalkerDioLoggerSettings**: 
  - `printErrorData`
  - `printErrorHeaders`
  - `printErrorMessage`
  - `errorFilter`

# 1.0.0
- Initial release of [talker_riverpod_logger](https://pub.dev/packages/talker_riverpod_logger)

Thanks to [jbdujardin](https://github.com/jbdujardin)