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

  Thanks for [Khaoz-Topsy](https://github.com/Khaoz-Topsy)

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

  Thanks for [jirehcwe](https://github.com/jirehcwe)

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
