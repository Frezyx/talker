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

# 4.3.5
- [talker_bloc_logger] Setup common time format from talker settings for Bloc logs

# 4.3.4
- [talker_riverpod_logger] Duplicated state logs fixes

Thanks to [ArinFaraj](https://github.com/ArinFaraj)

# 4.3.3
- [talker_bloc_logger] Fix bloc logs TimeFormat

Thanks to [Mooyeee](https://github.com/Mooyeee)

# 4.3.2
- [talker_riverpod_logger] Fix issue with display time inside riverpod package

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

# 4.3.1
- [talker_flutter] Fix showing times on FlutterScreen cards

Thanks to [fieldOfView](https://github.com/fieldOfView)

# 4.3.0
- [talker_flutter] Custom logs timestamp formattings

Thanks to [abdelaziz-mahdy](https://github.com/abdelaziz-mahdy)

# 4.2.4
- [talker_riverpod_logger] Print missing data on TalkerScreen 

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

# 4.2.3
- [talker_riverpod_logger] Include Provider's name in logs output

Thanks to [KoheiKanagu](https://github.com/KoheiKanagu)

# 4.2.2
- [talker_flutter] Support for Flutter 3.22, fix new version deprecations

# 4.2.1
- [talker_dio_logger] Add missing error setting for **TalkerDioLoggerSettings**: 
  - `printErrorData`
  - `printErrorHeaders`
  - `printErrorMessage`
  - `errorFilter`

Thanks to [Ali1Ammar](https://github.com/Ali1Ammar)
  
# 4.2.0
- Initial release of [talker_riverpod_logger](https://pub.dev/packages/talker_riverpod_logger)

Thanks to [jbdujardin](https://github.com/jbdujardin)

# 4.1.5
- [talker_flutter] Bump share_plus version to 9.0.0

# 4.1.4
- [talker_logger] Fix default logs printing method

# 4.1.3
- [talker_flutter] Bump share_plus version to 8.0.2
- [talker_flutter] Bump path_provider version to 2.1.2

# 4.1.2
- [talker_flutter] Bump group_button version to 5.3.4

# 4.1.1
- Fix TalkerLog.generateTextMessage exception info missing

Thanks to [heiha100](https://github.com/heiha100)

# 4.1.0
- Fix Exception and StackTrace is ignored for logs
- Fix typo at the beginning README.md 
- Fix TalkerScreen log type selector text colors

Thanks to [qwadrox](https://github.com/qwadrox) and [Danyalo](https://github.com/Danyalo)

# 4.0.3
- Support web for talker and talker_logger
- Update talker_bloc_logger README.md

Thanks to [melodysdreamj](https://github.com/melodysdreamj) and [MiladAtef](https://github.com/MiladAtef)

# 4.0.2
- Fix inconsistent colors at TalkerScreen
- Add **LogColors** typedef in TalkerTheme ```(Map<TalkerLogType, Color>)```

Thanks to [XanderD99](https://github.com/XanderD99)

# 4.0.1
- Fix talker configure method problems [issue #186](https://github.com/Frezyx/talker/issues/186)

Thanks to [K1yoshiSho](https://github.com/K1yoshiSho)

# 4.0.0
- Add ability to customize **colors** and **titles** of any Talker logs
- Add ability to customize **colors** of any logs in TalkerScreen UI 
- Add **TalkerLogType** enum for clear differentiation of logs by types.
- Update TalkerScreen UI (The interface is now even more user-friendly)
- Huge documentation update
- Make 100% test coverage of **talker_bloc_logger** and **talker_dio_logger**
- Add expand / collapse ability for one log card
- Packages versions synchronization (Now the versions of all core libraries will be identical)
- **BREAKING** TalkerDataInterface deleted (Now base data class is **TalkerData**)

- Fix: Text color not always visible [issue #174](https://github.com/Frezyx/talker/issues/174)
- Add custom title format [issue #170](https://github.com/Frezyx/talker/issues/170)
- Fix: Logger not resets log color [issue #86](https://github.com/Frezyx/talker/issues/86)

Check more details in [documentation](https://github.com/Frezyx/talker)

# 4.0.0-dev.6
- Make 100% tests coverage 
- Update example UI
- Add custom log titles documentation
- Fix TalkerScreen log colors setup
- Fix TalkerScreenTheme textColor providing

# 4.0.0-dev.5
- Huge documentation update
- Update talker_flutter styles
- Add expand / collapse ability for one log card
- Add colors customization examples

# 4.0.0-dev.4
- Add new tests to make 100% coverage
- Fix linter issues

# 4.0.0-dev.3
- Update settings setup method
- Fix migration issues

# 4.0.0-dev.1
- Add **colors** field in TalkerLoggerSettings class to setup custom colores for default logs
- Remove deprecated LogLevel title and color extensions
- **BREAKING**: Remove **LogLevel.good**

# 3.1.0
- Rename (fix typo) **LoggerFormater -> **LoggerFormatter** 
- Rename (fix typo) field **formater** -> **formatter** 
- Fix internal and docs typos 

Thanks to [wcoder](https://github.com/wcoder)

# 3.0.4
- Add topics in pubspec.yaml

# 3.0.3
- Update sdk version to **'>=2.15.0 <4.0.0'**

# 3.0.2
- Update **LogLevel** priority list

# 3.0.1

- Move back console_utils export

# 3.0.0

- ⚠️ Remove **TalkerLoggerInterface**
- ⚠️ Remove deprecated **LogLevel.fine** and **.fine()** log method 
- ⚠️ Rename **LogLevelTalkerLoggerFilter** -> **LogLevelFilter**, **TalkerLoggerFilter** -> **LoggerFilter**
- Move all important files on upper level and simplify folders navigation
- Remove kDefaultLoggerSettings constant
- Make console_utils private class

# 3.0.0-dev.6

- Remove kDefaultLoggerSettings constant
- Make console_utils private class

# 3.0.0-dev.5

- Delete deprecated **LogLevel.fine** and **.fine()** log method 

# 3.0.0-dev.4

- Update pubspec.yaml description

# 3.0.0-dev.3
- Move all important files on upper level and simplify folders navigation

# 3.0.0-dev.2

- Make LogLevel.fine deprecatd

# 3.0.0-dev.1

- Remove **TalkerLoggerInterface**
- Make fine log method Deprecated
- Rename LogLevelTalkerLoggerFilter -> LogLevelFilter
- Rename TalkerLoggerFilter -> LoggerFilter

# 2.2.1
- **FIX**: Fix color reset in console

Thnaks for [westito](https://github.com/westito)

## 2.2.0
- **INFO**: talker 2.2.0 release
- **INFO**: Update dependencies

## 2.2.0-dev.1
- **INFO**: Up version due to the talker_flutter update

## 2.1.1-dev.3
- **FEAT**: Implement debug logs title
- **INFO**: Up version due to the talker_flutter update

## 2.1.0
- **Talker mutual update**
See more in [releases](https://github.com/Frezyx/talker/releases)

## 2.0.0
- **Huge Talker update**
See more in [releases](https://github.com/Frezyx/talker/releases)

## 1.2.1
- **FEAT**: add output field to copyWith method 

  Thanks to [probka00](https://github.com/probka00)

## 1.2.0
- **FIX**: Temp change homepage
- **INFO**: Update README.md

## 1.1.1
- **INFO**: Implement custom Formatter usage example
- **FIX**: README $ images & docs

## 1.1.0
- **FEAT**: Implement ExtendedLoggerFormatter
- **FEAT**: Upgrade ColoredLoggerFormatter
- **FIX**: Typo Formater -> Formatter

## 1.0.0
First stable release! 🎉

## 0.12.0
- **BREAKING**: Change message field type from String to dynamic

## 0.11.1
- **FEAT**: Move back copyWith method

## 0.11.0
- **INFO**: Make 100% tests coverage
- **INFO**: Update package docs, examples, tests 

## 0.9.0
- **INFO**: Make small refactor

## 0.8.0
- **INFO**: Create README with documentation and examples
- **INFO**: Add TalkerLoggerSettings docs

## 0.7.0
- **FIX**: Rename and refactor internal code
- **INFO**: Add all public entities docs

## 0.6.0
- **FIX**: Remove lineSymbol and maxLineWidth field from LogDetails
- **INFO**: Add main class and LogDetails, extensions docs

## 0.5.1
- Remove unused code, fix default logger format

## 0.5.0
- Release 0.5.0 talker package
- Update README.md

## 0.4.0
- Update logs base formating and coloring

## 0.3.2
- Add coloring for log underline

## 0.3.1
- Make level nullable field in standart method

## 0.3.0
- Add simple methods for all levels log

## 0.2.0
- Update logs architecture
- Add filter and formater utils

## 0.1.0

- Initial version.
