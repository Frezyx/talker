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

## 2.3.4
- Update **talker** version to 3.1.7

## 2.3.3
- Update **talker** version to 3.1.6

## 2.3.2
- Update **talker** version to 3.1.5

## 2.3.1
- Update **talker** version to 3.1.4

## 2.3.0
- Update **talker** version to 3.1.0

## 2.2.3
- Update talker version to 3.0.4

## 2.2.2
- Add topics in pubspec.yaml
- Update talker version to 3.0.2

## 2.2.1
- Fix Response headers bug 

Thnaks for [matt400m](https://github.com/matt400m)

## 2.2.0
- Add **responseFilter** and **requestFilter** in **TalkerDioLoggerSettings**
Now you can add your custom logic to log only specific HTTP responses and resuests

## 2.1.2
- Fix linter issues

## 2.1.1
- Downgrade lints package to **2.0.0** version
- Update analysis options

## 2.1.0
- Rename **HttpRequestLog** -> **DioRequestLog**
- Rename **HttpResponseLog** -> **DioResponseLog**
- Rename **HttpErrorLog** -> **DioErrorLog**

## 2.0.2
- Replace deprecated DioError with **DioException**
- Update sdk version to **'>=2.15.0 <4.0.0'**

## 2.0.1
- Upgrade **dio** version to 5.2.0

## 2.0.0
- Upgrade **talker** version to 3.0.0
- Fix Addon currently exist [issue](https://github.com/Frezyx/talker/issues/102) 
- Remove addon functionality to simplify code base

## 2.0.0-dev.2
- Upgrade **talker** version to 3.0.0-dev.13

## 2.0.0-dev.1
- Upgrade talker to 3.0.0-dev.4 version
- Make titles well known 
  (WellKnownTitles.httpRequest.title, WellKnownTitles.httpResponse.title, WellKnownTitles.httpError.title)

# 1.3.0
- **FEAT**: Update talker_dio_logger dio version to 5.0.0

# 1.2.2
- **FEAT**: Add addonId field for create a lot of addon instances in talker

# 1.2.1
- **FEAT**: Tmp fix for conver json method exception for FormData

# 1.2.0 
- **FEAT**: Update talker version to 2.4.0
- **FEAT**: Setup internal talker addon registration
- **FEAT**: Add settings in talker_flutter settings 

# 1.1.0 
- **FEAT**: Add configure method to update [settings] of [TalkerDioLogger]

# 1.0.3
- **FIX**: Update talker version to 2.3.3

# 1.0.2
- **FIX**: Fix format

# 1.0.1
- **FIX**: Fix color override in dio logger
- **FIX**: Fix color reset in console

Thnaks for [westito](https://github.com/westito)

## 1.0.0
- **BREAKING**: Package available for dart applications as for Flutter apps 
(Flutter sdk was removed from package dependencies)
- **FEAT**: Upgrade logs formatting, more readable, simpler and more effective 
- **FEAT**: Implement DioError custom logs with new formatting

## 0.6.0
- **FEAT**: Implement requestPen and responsePen for 
setup custom request and response console message colors

## 0.5.0
- **Talker mutual update**
See more in [releases](https://github.com/Frezyx/talker/releases)

## 0.4.0
- **FEAT**: Implement Response.statusMessage printing
- **FEAT**: Implement printResponseMessage field in TalkerDioLoggerSettings

## 0.3.0
- **FIX**: Delete stackTrace for dio errors

## 0.2.0
- **FIX**: Add try/catch for interceptor to avoid FormData exceptions

## 0.1.3
- **FEAT**: Update talker_flutter version to 2.0.3

## 0.1.2
- **FEAT**: Update talker_flutter version to 2.0.2

## 0.1.1
- **FEAT**: Update talker_flutter version to 2.0.1

## 0.1.0
- **Huge Talker update**
See more in [releases](https://github.com/Frezyx/talker/releases)

## 0.1.0-dev.6

- **FEAT**: Downgrade min supported sdk version from 2.18 to 2.15

## 0.1.0-dev.5

- **FEAT**: provide documentation and usage examples

## 0.1.0-dev.4

- **FIX**: null status code showing

## 0.1.0-dev.3

- **FEAT**: Implement example Flutter app
- **FIX**: empty data and headers prints

## 0.1.0-dev.2
- **FEAT**: Fix print only not empty data and headers 

## 0.1.0-dev.1

Initial release with base **TalkerDioLogger** implementation
