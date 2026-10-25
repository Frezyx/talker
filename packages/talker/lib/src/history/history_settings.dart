part of '../settings.dart';

class TalkerHistorySettings {
  const TalkerHistorySettings({
    bool? enabled,
    this.storageEnabled = false,
    this.maxRuntimeItems,
    this.maxStorageItems,
    this.maxStorageSessions,
  }) : enabled = enabled ?? true;

  final bool enabled;
  final bool storageEnabled;
  final int? maxRuntimeItems;
  final int? maxStorageItems;
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
      maxRuntimeItems: maxRuntimeHistoryItems ?? maxRuntimeItems,
      maxStorageItems: maxStorageHistoryItems ?? maxStorageItems,
      maxStorageSessions: maxStorageSessions ?? this.maxStorageSessions,
    );
  }
}
