# 4.3.4
- [riverpod_logger] Duplicated state logs fixes

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
- Add new colors customization

# 3.2.0
- Add ability to setup custom history implementation
- Add **abstract class TalkerHistory**
- Add **DefaultTalkerHistory** implementation with basic (previous) functionality by default

Thanks to [Ppito](https://github.com/Ppito)

# 3.1.7
- Add package utils export 

Thanks to [Ppito](https://github.com/Ppito)

# 3.1.6
**talker_bloc_logger**
- Add onCreate, onClose logs
- Add **printClosings** **printCreations** settings fields (false by default)

Thanks to [cem256](https://github.com/cem256)

# 3.1.5
- Add ability to set own ErrorHandler 

Thanks to [Ppito](https://github.com/Ppito)

# 3.1.4
- Pad minutes and seconds for DateTime formatter

Thanks to [Reprevise](https://github.com/Reprevise)

# 3.1.3
- Fix analysis_options.yaml

# 3.1.2
- Fix analysis_options.yaml 
- Update README docs and examples

# 3.1.1
- Make 100% tests coverage
- Add Contributors section in project README

# 3.1.0
- Rename (fix typo) **LoggerFormater** -> **LoggerFormatter** 
- Rename (fix typo) Talker field **loggerFormater** -> **loggerFormatter** 
- Fix internal and docs typos 
- Update **talker_logger** version to 3.1.0

Thanks to [wcoder](https://github.com/wcoder)

# 3.0.5
- Fix StackTrace printning when exits in **TalkerLog**

Thanks to [IlyaZadyabin](https://github.com/IlyaZadyabin)

# 3.0.4
- - Add topics in pubspec.yaml

# 3.0.3
- Update **talker_logger** version to 3.0.4

# 3.0.2
- Update **talker_logger** version to 3.0.3

# 3.0.1
- Update sdk version to **'>=2.15.0 <4.0.0'**

# 3.0.0

**Lighter, simpler, more powerful**

- Remove deprecated in constructor and configure() method:
  - **LoggerFormatter? loggerFormater**
  - **LoggerFilter? loggerFilter** 
  - **TalkerLoggerSettings? loggerSettings** 
Now you can setup this fields only in TalkerLogger constructor

- Remove deprecated methods:
  - **handleError()** **handleException()**
  - **fine()** log method
Now you can use the **handle()** method to achieve the same functionality in both methods.

- Add **observer** field instead of reomoved **observers**

# 3.0.0-dev.13

- Add **TalkerObserver** to README.md docs

# 3.0.0-dev.12

- Add **observer** field instead of reomoved **observers**
- Remove **observers** field to simplify API

# 3.0.0-dev.11

- Upgrade **talker_logger** version to 3.0.0-dev.5

# 3.0.0-dev.10

- Delete deprecated in constructor and configure() method:
  - **LoggerFormatter? loggerFormater**
  - **LoggerFilter? loggerFilter** 
  - **TalkerLoggerSettings? loggerSettings** 

Now you can setup this fields only in TalkerLogger constructor

- Delete deprecated methods:
  - **handleError()** **handleException()**

Now you can use the **handle()** method to achieve the same functionality in both methods.

- Delete deprecated method:
  - **fine()** log method

# 3.0.0-dev.9

- Update README, and pubspec.yaml docs

# 3.0.0-dev.8

- Rename route title to ROUTE

# 3.0.0-dev.7

- Make loggerSettings, loggerFilter, loggerFormater, loggerOutput Deprecated
  Currently you can setup this felds and all other logger settings only in TalkerLogger constructor

# 3.0.0-dev.6

- Add WellKnownTitle route
- Replace [ERROR] and [EXCEPTION] to [error] and [exception] titles

# 3.0.0-dev.5

- Update talker_logger version to 3.0.0-dev.3

# 3.0.0-dev.4

- Make _Filter class internal
- Remove Talker equality overriding

# 3.0.0-dev.3

- Move all important files on upper level and simplify folders navigation

# 3.0.0-dev.2

- Make TalkerObserver abstract class with self methods
  Remove constructor with callback's initialization

# 3.0.0-dev.1

- Delete talker addons feature
- Delete TalkerInterface class
- Make handleException and handleError deprecated methods
- Make fine log method deprecated

# 2.4.1
- Add deprecations for **handleError** and **handleException** methods

# 2.4.0
- **FEAT**: Ad addons functionality: registerAddon, resetAddon methods, addons getter

# 2.3.5
- **FEAT**: Fix exports

# 2.3.4
- **FEAT**: Add equality operators override for talker and settings

# 2.3.3
- **FIX**: Settings enable and disable rules

# 2.3.2
- **FIX**: Settings field configure bug

# 2.3.1
- **FIX**: Settings field initialization bug
- **FEAT**: Add copyWith to TalkerSettings

# 2.3.0
- **FEAT**: Make settings Talker public field

# 2.2.1
- **FIX**: Fix color reset in console

Thnaks for [westito](https://github.com/westito)

## 2.2.0
- **FIX**: talker release 2.2.0
- **FIX**: Change Debug "Log" title to "Debug"

## 2.1.1-dev.3
- **INFO**: Up version due to the talker_flutter update

## 2.1.1-dev.2
- **INFO**: Up version due to the talker_flutter update

## 2.1.0+1
- **INFO**: Improve README.md
- **INFO**: Improve pubspec.yaml

## 2.1.0
- **FEAT**: Implement filter for Talker constructor. 
Now you can filter data by logger and by talker instance as default.

## 2.0.0
- **Huge Talker update**
See more in [releases](https://github.com/Frezyx/talker/releases)

## 1.3.0
- **FEAT**: Add output to Talker constructor
- **FEAT**: Update talker_logger to 1.2.1 version
## 1.2.0
- **INFO**: Huge README update 
- **INFO**: Update talker_logger to 1.2.0 version

## 1.1.1
- **FEAT**: Update talker_logger to 1.1.1 version

## 1.1.0
talker_logger updates:
- **FEAT**: Implement ExtendedLoggerFormatter
- **FEAT**: Upgrade ColoredLoggerFormatter
- **FIX**: Typo Formater -> Formatter

## 1.0.0
First stable release! 🎉

## 0.12.0
  - **FEAT**: Change message field type from String to dynamic<br>for all log [error(),critical(),info(),fine(),good(),debug(),verbose(),warning()] methos and handle [handle(), handleError(), hanldeException()] methods

## 0.11.0
  - **FIX** Fix filter
  - **FIX** Refactor package base
  - **INFO** Make 100% tests coverage
  - **INFO** Update README.md

## 0.10.0
  - **BREAKING** Remove field registeredTypes
  - **FIX** Fix history bug
  - **FIX** Disable writeToFile in settings for first stable release
  - **INFO** Update example and add some new tests

## 0.9.1
  - **FIX** Make self DateTime formating
  - **FIX** Delete intl package

## 0.9.0
  - **BREAKING** Create common Talker constructor
  - **BREAKING** After this version Talker is not singleton class 
  - **FEAT** Now you can create a lot of Talker instances for you app
  - **FEAT** Now ***configure()*** method is not async

## 0.8.1
- **talker_logger** update to 0.8.0 version
- talker_logger changes:
  - **INFO**: Create README with documentation and examples
  - **FIX**: Rename and refactor internal code
  - **INFO**: Add all public entities docs
  - **FIX**: Remove lineSymbol and maxLineWidth field from LogDetails

## 0.8.0
- **FEAT** Add enable and disable methods for Talker

## 0.7.1
- **FEAT** Add logger settings, filter, formater fields to configure talker method

## 0.7.0
- **BREAKING** Remove talker_error_handler package from talker deps
- **BREAKING** Rewrite error handler on talker package base
- **BREAKING** Update handle error / exceptions methods

## 0.6.1
- **BREAKING** Remove TalkerDataInterface, 
TalkerLog, TalkerError, TalkerException field additional data
    

## 0.6.0
- Implement filter for logs

## 0.5.2
- Add title for default models

## 0.5.1
- Fix README images urls

## 0.5.0
- Add all docs
- Update core packages versions to 0.5.0
- Fix package issues

## 0.4.0
- Add logTyped method
- Add documentation
- Updated settings and working

## 0.3.0
- Update settings cnfiguration
- Update internal logic
- Update internal packages

## 0.2.8
- Add useConsoleLogs settings field

## 0.2.7
- Update logger version

## 0.2.6
- Add AnsiPen customization for log method

## 0.2.5
- Update observer model

## 0.2.4
- Implement simple log methods

## 0.2.3
- Fix default (null) errorLevel -> logLevel

## 0.2.2
- Fix error_handler version

## 0.2.1
- Fix nested packages

## 0.2.0
- Simplified package api
- Fix Talker lazy configuration

## 0.1.0

- Initial version.
