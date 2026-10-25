part of '../settings.dart';

class TalkerHistorySettings {
  const TalkerHistorySettings({
    bool? enabled,
    this.storageEnabled = false,
    this.maxRuntimeHistoryItems,
    this.maxStorageHistoryItems,
    this.maxStorageSessions,
  }) : enabled = enabled ?? true;

  final bool enabled;
  final bool storageEnabled;
  final int? maxRuntimeHistoryItems;
  final int? maxStorageHistoryItems;
  final int? maxStorageSessions;

  TalkerHistorySettings copyWith({
    bool? enabled,
    bool? storageEnabled,
    int? maxRuntimeHistoryItems,
    int? maxStorageHistoryItems,
    int? maxStorageSessions,
  }) {
    return TalkerHistorySettings(
      enabled: enabled ?? this.enabled,
      storageEnabled: storageEnabled ?? this.storageEnabled,
      maxRuntimeHistoryItems:
          maxRuntimeHistoryItems ?? this.maxRuntimeHistoryItems,
      maxStorageHistoryItems:
          maxStorageHistoryItems ?? this.maxStorageHistoryItems,
      maxStorageSessions: maxStorageSessions ?? this.maxStorageSessions,
    );
  }
}
