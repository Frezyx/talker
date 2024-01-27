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
