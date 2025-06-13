# 4.8.3
- [talker_riverpod_logger] add an error filter

Thanks to [lucavenir](https://github.com/lucavenir)

# 4.8.2
- [talker] Add `CustomLog` Documentation
- [example] Update plugin com.android.application to v8.10.1
- [example] Update dependency gradle to v8.14.1

Thanks to [MeyerOppelt](https://github.com/MeyerOppelt)

# 4.8.1
- [talker_dio_logger] Add logging of request`s extra

Thanks to [lucavenir](https://github.com/lucavenir)

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
- Talker Actions UI updated

# 3.6.0
- Add ability to setup custom history implementation
- Add **abstract class TalkerHistory**
- Add **DefaultTalkerHistory** implementation with basic (previous) functionality by default

Thanks to [Ppito](https://github.com/Ppito)

# 3.5.7
- Add package utils export 

Thanks to [Ppito](https://github.com/Ppito)

# 3.5.6
**talker_bloc_logger**
- Add onCreate, onClose logs
- Add **printClosings** **printCreations** settings fields (false by default)

Thanks to [cem256](https://github.com/cem256)

# 3.5.5
- Add ability to set own ErrorHandler for talker instance

Thanks to [Ppito](https://github.com/Ppito)

# 3.5.4
- Bump share_plus package to 7.2.1

# 3.5.3
- Fix the overflow issue of Talker Monitor

Thanks to [Kabak-Siarhei](https://github.com/Kabak-Siarhei)

# 3.5.2
- Bump talker version to 3.1.4
  - Pad minutes and seconds for DateTime formatter

# 3.5.1
- Add TalkerRouteObsever documentatuion
- Fix share_plus version 7.1.0

# 3.5.0
- Update internal packages versions
- - Bump share_plus package to 8.0.0
- - Bump path_provider package to 2.1.1

# 3.4.0
- Bump share_plus package to 7.1.0

# 3.3.1
- Update README docs and examples

# 3.3.0
- Support web platform downloading logs 

Thanks to [Kabak-Siarhei](https://github.com/Kabak-Siarhei)

# 3.2.10
- Add TalkerScreenTheme **cardColor** customization field

# 3.2.9
- Fix **appBarleading** showing

# 3.2.8
- Add **appBarleading** field to TalkerScreen and TalkerView constructor

# 3.2.7
- Fix TalkerWrapper error looping

Thanks to [s0nerik](https://github.com/s0nerik)

# 3.2.6
- Fix appbar icon colors
- Rename part of internal classes

# 3.2.5
- Make **controller**, **theme**, **appBarTitle** not required for TalkerView
- Make TalkerScreen Stateless instead of Stateful

# 3.2.4
- Fix AppBar title text color

# 3.2.3
- Add **TalkerView** in package exports

# 3.2.2
- Fix logs expanding and collapsing in TalkerView

# 3.2.1
- Refactor TalkerScreen decomposition 
- Extract TalkerView, TalkerViewAppBar

# 3.2.0
- Rename (fix typo) field **backgroudColor** -> **backgroundColor**
- Fix internal and docs typos 
- Update **talker** version to 3.1.0
- Update **group_button** version to 5.3.2

Thanks to [wcoder](https://github.com/wcoder)

# 3.1.12
- Remove using paddingOf to support old flutter versions

# 3.1.11
- refactor and enhance UI
- Fix typo **bacgroundColor** -> **backgroundColor** in SnackbarContent constructor
- Add the **dismissButtonText** Widget to SnackbarContent
- Add the **dismissButton** Widget to SnackbarContent
- Add the **titleTextStyle** TextStyle to SnackbarContent
- Add the **messageTextStyle** TextStyle to SnackbarContent
- Add an **onPressed** callback to SnackbarContent
- Use paddingOf instead size this method will cause the given [context] to rebuild any time that the [MediaQueryData.padding] property of the ancestor [MediaQuery] changes. Checkout the following PR for more informations about MediaQuery as InheritedModel

Thanks to [jnelle](https://github.com/jnelle)
# 3.1.10
- Update **talker** version to 3.0.5

# 3.1.9
- Add topics in pubspec.yaml

# 3.1.8
- Update **talker** version to 3.0.4

# 3.1.7
- Set the exact size of the text in the search TextField
- Fix large text in search bar

# 3.1.6
- Update **talker** version to 3.0.2

# 3.1.5
- Fix typos in package documentation

Thanks to [vicenterusso](https://github.com/vicenterusso)

# 3.1.4
- Fix TalkerScreen scrolling

# 3.1.3
- Update sdk version to **'>=2.15.0 <4.0.0'**

# 3.1.2
- Make fixed text size in talker data list

# 3.1.1
- Fix TalkerFlutter output initialization

# 3.1.0
- Add **runTalkerZonedGuarded** method to setup handle all 
app unhandled exceptions with one method

Thanks to [zezo357](https://github.com/zezo357)

# 3.0.0

**Lighter, simpler, more powerful**

- Big UI/UX updates. Interacting with logs from the application has become even easier now.
- Rename **TalkerHistoryBuilder** -> **TalkerBuilder**
- Remove old **TalkerBuilder**
- Remove **FlutterTalkerDataInterface** and subclasses instead of **TalkerDataInterface**
- Remove **iconsColor** field from TalkerScreenTheme
- Remove Filter bottom sheet (now this functionality is avaliable at TalkerScreen)

# 3.0.0-dev.12

- Add **TalkerObserver** in **TalkerFlutter** extension constructor

# 3.0.0-dev.11

- Update **talker** version to 3.0.0-dev.13

# 3.0.0-dev.10

- Update **talker** version to 3.0.0-dev.11
- Delete LogLevel.fine deprecation usage in extensions

# 3.0.0-dev.9

- Update TalkerFlutter extension (Remove deprecated fileds)
- Update talker version to 3.0.0-dev.10

# 3.0.0-dev.8

- Update README, and pubspec.yaml docs

# 3.0.0-dev.7

- Update talker version to ^3.0.0-dev.8
- Fix TalkerFlutter logs colors for http and bloc logs

# 3.0.0-dev.6

- Update **TalkerScreen** UI
- Fix AppBar SafeArea

# 3.0.0-dev.5

- Rename **TalkerHistoryBuilder** -> **TalkerBuilder**
- Remove old **TalkerBuilder**

# 3.0.0-dev.4

- Make loggerSettings, loggerFilter, loggerFormater, loggerOutput Deprecated
  Currently you can setup this felds and all other logger settings only in TalkerLogger constructor

# 3.0.0-dev.3

- Update Talker screen UI
- Remove Filter bottom sheet (now this functionality is avaliable at TalkerScreen)
- Remove **iconsColor** field from TalkerScreenTheme

# 3.0.0-dev.2
- Fix settings updates checking in UI
- Update example

# 3.0.0-dev.1

- Rename TalkerMonitorItem -> TalkerMonitorCard
- Remove FlutterTalkerDataInterface and subclasses
- Remove talker_dio_logger depencency
- Update talker version to 3.0.0-dev.6
- Update internal packages versions

# 2.4.3
- **FEAT**: update path_provider version to 2.0.13

# 2.4.2
- **FIX**: logs sharing on windows devices

Thanks to [zezo357](https://github.com/zezo357)

# 2.4.1
- **FEAT**: Update talker_dio_logger to 1.3.0 and internal packages

# 2.4.0
- **FEAT**: Add settings bottom sheet on main screen
- **FEAT**: Add talker_dio_logger settings on settings bottom sheet
- **FEAT**: Make great UI improvements
- **FEAT**: Setup talker_dio_logger addon functionality
- **FEAT**: Make logs reversed as default

# 2.3.1
- **FEAT**: Add initial TalkerSettings screen to interact with Talker configuration

# 2.3.0
- **FEAT**: Add filters and fast actions for http calls monitor
- **FEAT**: Expanded size of log item click zone

# 2.2.1
- **FIX**: Fix color reset in console

Thnaks for [westito](https://github.com/westito)

## 2.2.0
- **FEAT**: Create FlutterTalker extensions for enable iOS/ MacOS colored logging
- **FEAT**: Implement [TalkerMonitor](https://github.com/Frezyx/talker/tree/dev#talkermonitor) for sorting, warning, infos, verbose errors
- **FEAT**: Implement [Talker Http Monitor](https://github.com/Frezyx/talker/tree/dev#talkermonitor) for http request-response analytics and monitoring
- **FEAT**: Web demo example avaliable at [frezyx.github.io/talker](https://frezyx.github.io/talker)

## 2.2.0-dev.1
- **INFO**: Init prerelease version
- **INFO**: Add web demo example

## 2.1.1-dev.3
- **FEAT**: TalkerMonitor sorting, warning, infos, verbose errors
- **FEAT**: Talker Http Monitor for http request-response analytics and monitoring

## 2.1.1-dev.2
- **FEAT**: Implement initial TalkerMonitor functionality

## 2.1.1-dev.1
- **FEAT**: Create FlutterTalker extensions for enable iOS/ MacOS colored logging

## 2.1.1
- **FIX**: TalkerFilter Cannot add to an unmodifiable list issue

Thnaks for [ProjectAJ14](https://github.com/ProjectAJ14)

## 2.1.0+1
- **INFO**: Improve README.md
- **INFO**: Improve pubspec.yaml

## 2.1.0
- **FEAT**: Implement filter for Talker constructor. 
Now you can filter data by logger and by talker instance as default.

## 2.0.6
- **FIX**: Update internal packages

## 2.0.5
- **FIX**: Analyzer issues about shareFiles method deprecation

## 2.0.4
- **FIX**: Analyzer issues about shareFiles method deprecation

## 2.0.3
- **FIX**: Talker logs card gaps

## 2.0.2
- **FIX**: Ignore routes with null settings.name in **TalkerRouteObserver**

## 2.0.1
- **FIX**: Logs text generation for copy and share (save to file) methods

## 2.0.0
- **FEAT**: Update TalkerScreen actions UI 
- **FEAT**: Implement logs file sharing 
- **FEAT**: Update logs filter UI
- **INFO**: Code base refactoring
- **Huge Talker update**
See more in [releases](https://github.com/Frezyx/talker/releases)

## 1.7.1
- **FIX**: FlutterTalkerException, FlutterTalkerError, FlutterTalkerLog now implements FlutterTalkerDataInterface

## 1.7.0
- **INFO**: HaveFlutterColorInterface -> TalkerFlutterAdapterInterface
- **FEAT**: Implement generateFlutterTextMessage method for **FlutterTalkerDataInterface**, **FlutterTalkerLog**, **FlutterTalkerError**, **FlutterTalkerException** classes

Now you can extend your flutter app logs.
- **generateFlutterTextMessage** used in TalkerScreen (UI list of logs)
- **generateTextMessage** used in console logs and history

## 1.6.0
- **FIX**: Logs cutting by flutter via print method. 
Now Talker constructor have output filed to provide callback.
For flutter applications, you need to pass debugPrint as output method
See more in talker_flutter initialization on project README.md
- **INFO**: Update talker to 1.3.0 version

## 1.5.1
- **INFO**: Huge README update 
- **INFO**: Update talker to 1.2.0 version

## 1.5.0
- **FEAT**: Implement TalkerHistoryBuilder widget to create your own custom designed logs UI screen
- **FEAT**: Implement TalkerBuilder widget to create your own custom designed screen with last log message showing
- **INFO**: Update talker to 1.1.1 version

## 1.4.2
- **INFO**: Add TalkerScreen appBarTitle field

  Thanks to [Khaoz-Topsy](https://github.com/Khaoz-Topsy)

## 1.4.1
- **INFO**: Add documentation for TalkerWrapper

## 1.4.0
- **FEAT**: Implement TalkerWrapper widget (to showing snackbars)
- **FEAT**: Implement base error messages showing in UI (for user)

## 1.3.0
talker_logger updates:
- **FEAT**: Implement ExtendedLoggerFormatter
- **FEAT**: Upgrade ColoredLoggerFormatter
- **FIX**: Typo Formater -> Formatter


## 1.2.0
* **FEAT** Add default ordering setting for logs at TalkerScreen

  Thanks to [jirehcwe](https://github.com/jirehcwe)

## 1.1.0
  - **FEAT** Implement [TalkerListener](https://frezyx.github.io/talker/guide/talker-flutter.html#talkerlistener) widget to handle talker data stream

## 1.0.0
First stable release! 🎉

## 0.12.0
  - **INFO** Update talker version to 0.12.0

## 0.11.0
  - **INFO** Update talker version to 0.11.0

## 0.10.0
  - **FEAT** Create extended example and base example
  - **FIX** Make refactor in internal UI code
  - **FIX** Fix examples
  - **INFO** Update group_button version

## 0.9.0
  - **FEAT** Add expand button for hiding or revealing logs
  - **FEAT** Update TalkerScreen log UI
  - **FIX** Saving selected filters after sheet closing

## 0.8.1
- **talker_logger** update to 0.8.0 version
- talker_logger changes:
  - **INFO**: Create README with documentation and examples
  - **FIX**: Rename and refactor internal code
  - **INFO**: Add all public entities docs
  - **FIX**: Remove lineSymbol and maxLineWidth field from LogDetails

## 0.8.0
- **INFO** Add all package documentation
- **INFO** Update talker package to 0.8.0 version

## 0.6.0
- Update internal packages

## 0.5.4
- Update group_button version to 4.5.0
- Fix [issue 12](https://github.com/Frezyx/talker/issues/12) 

## 0.5.3
- Update talker version to 0.7.0

## 0.5.2
- Fix display message parsing

## 0.5.1
- Update display message UI
- Update talker version to 0.6.1

## 0.5.0
- Implement UI filter for convenient work with the console in the application

## 0.4.1
- Add Flutter Colors extended Talker models <br> to customize colors of your UI logs

## 0.4.0
- Update talker version to 0.5.0

## 0.3.0
- Update all packages to latest version
- Fix UI coloring

## 0.2.2
- Update Talker version

## 0.2.1
- Fix Talker to TalkerInterface

## 0.2.0
- Add logs list copy method
- Fix log colors

## 0.1.0

* Initial version
