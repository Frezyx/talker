# 4.5.3
- [talker_http_logger] Add HttpErrorLog for wrong http statuses

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
- Update **talker_logger** settings setup method

# 4.0.0-dev.2
- Fix types and remove unused code

# 4.0.0-dev.1
- First version with Logs keys implementation 
- **BREAKING** TalkerDataInterface deleted
- Add new talker colors customization

# 2.4.0
- Update **talker** version to 3.2.0
- Add ability to setup custom history implementation
- Add **abstract class TalkerHistory**
- Add **DefaultTalkerHistory** implementation with basic (previous) functionality by default

Thanks to [Ppito](https://github.com/Ppito)

## 2.3.3
- Update **talker** version to 3.1.7

## 2.3.2
- Update **talker** version to 3.1.6
- Fix last deploy issues (Member not found for WellKnownTitles issue)

## 2.3.1
- Update README.md

## 2.3.0
- Add onCreate, onClose logs
- Add **printClosings** **printCreations** settings fields (false by default)

Thanks to [cem256](https://github.com/cem256)

## 2.2.2
- Update **talker** version to 3.1.5

## 2.2.1
- Update **talker** version to 3.1.4

## 2.2.0
- Rename (fix typo) **recvie** -> **receive** in BlocEventLog
- Upgrade **talker** version to 3.1.0

Thanks to [wcoder](https://github.com/wcoder)
## 2.1.1
- Add topics in pubspec.yaml
- Update talker version to 3.0.4
- Update sdk version to **'>=2.15.0 <4.0.0'**
## 2.1.0
- Add logging for **onChange** method to enable **Cubit**'s logs
- Add **printEvents**, **printTransitions**, **printChanges** fields in **TalkerBlocLoggerSettings**

## 2.0.0
- Upgrade **talker** version to 3.0.0

## 2.0.0-dev.3
- Upgrade **talker** version to 3.0.0-dev.13

## 2.0.0-dev.2
- Downgrade meta version to 1.8.0

## 2.0.0-dev.1
- Upgrade talker to 3.0.0-dev.4 version
- Make titles well known 
  (WellKnownTitles.blocEvent.title & WellKnownTitles.blocTransition.title)

## 1.1.0
- **FEAT**: Add transitionFilter and eventFilter to filtering logs

## 1.0.2
- **FIX**: message generation for talker_flutter

## 1.0.1
- **FIX**: package path in example code sample

Thanks to [SamuelMTDavies](https://github.com/SamuelMTDavies)

## 1.0.0
- **FEAT**: Add TalkerBlocLoggerSettings for customize settings
- **FEAT**: Add Talker addon functionality
- **FEAT**: Upgrade logs formatting


## 0.1.1
- **FEAT**: Update talker version to 2.4.0

## 0.1.0

Initial release with base **TalkerBlocObserver** implementation
