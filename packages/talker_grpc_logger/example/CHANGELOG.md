# 5.0.2
- [talker_riverpod_logger] Bump riverpod version to 3.0.0
- adopt Riverpod 3 provider observer signatures with ProviderObserverContext
- switch to NotifierProvider.autoDispose and ProviderContainer.test from Riverpod 3 APIs

Thanks to [lucavenir](https://github.com/lucavenir)

# 5.0.1
- [talker_flutter] Bump share_plus version to 12.0.0
- [talker] Fix talker.handle docs to use stack trace before error message

Thanks to [Ali-Toosi](https://github.com/Ali-Toosi)

# 5.0.0
- - [talker_chopper_logger] Release logger for Chopper http clint package
- [talker_grpc_logger] Release logger for gRPC package

- [talker] Add ``registeredKeys`` field into ``TalkerSettings`` for third-party packages
- [talker] Remove deprecated ``titles`` and ``types`` from ``TalkerFilter``
- [talker] Add ``enabledKeys`` and ``disabledKeys`` fields into ``TalkerFilter`` to replace old filtering logic
- [talker] Upgrade **BaseTalkerFilter** class - add new filtering way by **List<String> keys** field
- [talker] Deprecate **titles** and **types** fields from **BaseTalkerFilter**
- [talker_flutter] Add ``TalkerFilter`` configuration on ``TalkerScreen``
- [talker_dio_logger] Add ``TalkerKey``s registration
- [talker_http_logger] Add ``TalkerKey``s registration
- [talker_bloc_logger] Add ``TalkerKey``s registration
- [talker_riverpod_logger] Add ``TalkerKey``s registration
- [talker_dio_logger] Remove unused addonId field from dio_logger
- [talker_dio_logger] Add ``FormData`` parser for request logs data
- [talker_dio_logger] Fix ``FormData``s ``contentType`` field

Thanks to [Frezyx](https://github.com/Frezyx)

# 5.0.0-dev.16
- [common] Update dependency lints to v6
- [common] Optimize images

Thanks to [renovatebot](https://github.com/renovatebot)

# 5.0.0-dev.15
- - [talker_grpc_logger] Add test and github workflow

Thanks to [Frezyx](https://github.com/Frezyx)

# 5.0.0-dev.14
- - [talker_grpc_logger] Add dart-style documentation

Thanks to [Frezyx](https://github.com/Frezyx)

# 5.0.0-dev.13
- [talker_grpc_logger] Initial release with general package version
- [talker] Add grpc keys into `TalkerKey` class

Thanks to [Frezyx](https://github.com/Frezyx)

## 1.0.0

- Initial version.
