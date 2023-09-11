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
