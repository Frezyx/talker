# 0.1.0-dev.31
- [talker_bloc_logger] Bump bloc version to 9.0.0

# 0.1.0-dev.30
- [talker_flutter] Proper migration of support to the web using both html and wasm
- [talker_flutter] Update example dart sdk version to '>=3.6.0 <4.0.0'

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

# 0.1.0-dev.29
- [talker_flutter] Correction the import file name in the talker_flutter log downloader web

Thanks to [samanzamani](https://github.com/samanzamani)

# 0.1.0-dev.28
- [talker_flutter] Migrate downloadLogs export to new js_interop package

# 0.1.0-dev.27
- [talker_flutter] Add new web api support for download logs file

# 0.1.0-dev.26
- [talker_flutter] Add support WASM for Flutter Web
- [talker_flutter] Support flutter 3.27, remove deprecations

Thanks to [abdelaziz-mahdy](https://github.com/abdelaziz-mahdy)

# 0.1.0-dev.25
- [talker_flutter] Add copy functionality for filtered logs

Thanks to [abdelaziz-mahdy](https://github.com/abdelaziz-mahdy)

# 0.1.0-dev.24
- [talker] Add history logging filter by LogLevel
- [talker_flutter] Fix TalkerScreen does not respect configured LogLevel setting

Thanks to [mylukin](https://github.com/mylukin)

# 0.1.0-dev.23
- [talker_flutter] Add isLogsExpanded and isLogOrderReversed flags to TalkerScreen widget

Thanks to [Ilushnik](https://github.com/Ilushnik) 

# 0.1.0-dev.22
- [talker_http_logger] Add HttpErrorLog for wrong http statuses

Thanks to [yelmuratoff](https://github.com/yelmuratoff) 

# 0.1.0-dev.21
- [talker_flutter] Add fallback Flutter screen log card color by LogLevel

# 0.1.0-dev.20
- [talker_flutter] Fix mapping LogColors to Flutter Color (Logs screen)

# 0.1.0-dev.19
More Flexible Interaction with Custom Logs  
- **BREAKING** [talker] Change the type of `colors` parameter in the `TalkerSettings` class from `Map<TalkerLogType, AnsiPen>?` to `Map<String, AnsiPen>?`. Custom colors must now use a string key for log types.  
- **BREAKING** [talker] Change the type of `titles` parameter in the `TalkerSettings` class from `Map<TalkerLogType, String>?` to `Map<String, String>?`. Custom titles must now use a string key for log types.  
- **BREAKING** [talker_flutter] Change the type of `colors` parameter in the **TalkerScreenTheme** class from `Map<TalkerLogType, Colors>?` to `Map<String, Colors>?`. Custom colors must now use a string key for log types.  
- [talker] Add new tests and updated existing ones.  
- [talker] Update the documentation for log customization.

Thanks to [yelmuratoff](https://github.com/yelmuratoff) 

# 0.1.0-dev.18
- [talker_dio_logger] Make encoder constant private

# 0.1.0-dev.17
- [talker] Reanme **logTyped** method to **logCustom**
- [talker] Add **Deprecated** annotation for logTyped method

# 0.1.0-dev.16
- [talker_logger] Add enable option field to control log output (on talker_logger level)

Thanks to [weitsai](https://github.com/weitsai)

# 0.1.0-dev.15
- [talker_dio_logger] Add enable option field to control log output (on talker_dio_logger level)

Thanks to [weitsai](https://github.com/weitsai)

# 0.1.0-dev.14
- [talker_http_logger] Bump http_interceptor package version to **2.0.0**

# 0.1.0-dev.13
- [talker] Fix provide pen color field in log() method
- [talker] Android dependecies actualization and bug fixing in example app code

Thanks to [HE-LU](https://github.com/HE-LU) and [venkat9507](https://github.com/venkat9507)

# 0.1.0-dev.12
- [talker] Stable ```TimeFormat``` release (Support of custom time formatting for every talker package)
- [talker_riverpod_logger] Bump version to talker common versions system

# 0.1.0-dev.11
- [talker_bloc_logger] Setup common time format from talker settings for Bloc logs

# 0.1.0-dev.10
- [talker_riverpod_logger] Duplicated state logs fixes

Thanks to [ArinFaraj](https://github.com/ArinFaraj)

# 0.1.0-dev.9
- [talker_bloc_logger] Fix bloc logs TimeFormat

Thanks to [Mooyeee](https://github.com/Mooyeee)

# 0.1.0-dev.8
- [talker_riverpod_logger] Fix issue with display time inside riverpod package

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

# 0.1.0-dev.7
- [talker_flutter] Fix showing times on FlutterScreen cards

Thanks to [fieldOfView](https://github.com/fieldOfView)

# 0.1.0-dev.6
- [talker_flutter] Custom logs timestamp formattings

Thanks to [abdelaziz-mahdy](https://github.com/abdelaziz-mahdy)

# 0.1.0-dev.5
- [talker_riverpod_logger] Print missing data on TalkerScreen 

Thanks to [yelmuratoff](https://github.com/yelmuratoff)

## 0.1.0-dev.4
- [talker_riverpod_logger] Include Provider's name in logs output

## 0.1.0-dev.3

- [talker] Bump version to 4.1.4

## 0.1.0-dev.2

- Update README.md

## 0.1.0-dev.1

- Initial version.
- Implement **TalkerHttpLogger** working with InterceptedClient 
