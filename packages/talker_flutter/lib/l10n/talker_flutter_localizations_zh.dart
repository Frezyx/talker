// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'talker_flutter_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class TalkerFlutterLocalizationsZh extends TalkerFlutterLocalizations {
  TalkerFlutterLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get talkerMonitor => '监控';

  @override
  String talkerMonitorType(String typeName) {
    return '监控 $typeName';
  }

  @override
  String get settings => '设置';

  @override
  String get talkerSettings => '设置';

  @override
  String get packagesSettings => '包设置';

  @override
  String get enabled => '启用';

  @override
  String get useConsoleLogs => '使用控制台日志';

  @override
  String get useHistory => '使用历史记录';

  @override
  String get reverseLogs => '反转日志';

  @override
  String get copyAllLogs => '复制所有日志';

  @override
  String get copyFilteredLogs => '复制筛选日志';

  @override
  String get expandLogs => '展开日志';

  @override
  String get collapseLogs => '折叠日志';

  @override
  String get cleanHistory => '清空历史';

  @override
  String get shareLogsFile => '分享日志文件';

  @override
  String get logItemCopied => '日志项已复制到剪贴板';

  @override
  String get allLogsCopied => '所有日志已复制到缓冲区';

  @override
  String get filteredLogsCopied => '所有筛选日志已复制到缓冲区';

  @override
  String get undo => '撤销';

  @override
  String get errors => '错误';

  @override
  String get exceptions => '异常';

  @override
  String get warnings => '警告';

  @override
  String get infos => '信息';

  @override
  String get verboseDebug => '详细与调试';

  @override
  String get httpRequests => 'Http 请求';

  @override
  String httpRequestsExecuted(int count) {
    return '已执行 $count 个 http 请求';
  }

  @override
  String successfulResponses(int count) {
    return '$count 个成功';
  }

  @override
  String get responsesReceived => ' 个响应已接收';

  @override
  String failureResponses(int count) {
    return '$count 个失败';
  }

  @override
  String unresolvedErrors(int count) {
    return '应用程序有 $count 个未解决的错误';
  }

  @override
  String unresolvedExceptions(int count) {
    return '应用程序有 $count 个未解决的异常';
  }

  @override
  String warningsCount(int count) {
    return '应用程序有 $count 个警告';
  }

  @override
  String infoLogsCount(int count) {
    return '信息日志数量: $count';
  }

  @override
  String verboseDebugLogsCount(int count) {
    return '详细与调试日志数量: $count';
  }

  @override
  String get talkerActions => '操作';

  @override
  String get errorOccurred => '发生错误';

  @override
  String get data => '数据';

  @override
  String get type => '类型';
}
