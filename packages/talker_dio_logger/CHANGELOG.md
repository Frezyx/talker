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
