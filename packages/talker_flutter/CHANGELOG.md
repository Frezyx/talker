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
