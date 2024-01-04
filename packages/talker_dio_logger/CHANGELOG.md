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
