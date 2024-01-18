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
